package render

import (
	"fmt"
	"sort"

	"github.com/chainguard-dev/malcontent/pkg/malcontent"
	"github.com/chainguard-dev/malcontent/pkg/report"
	orderedmap "github.com/wk8/go-ordered-map/v2"
)

func riskStatistics(files *orderedmap.OrderedMap[string, *malcontent.FileReport]) ([]malcontent.IntMetric, int, int) {
	riskMap := make(map[int][]string, files.Len())
	riskStats := make(map[int]float64, files.Len())

	// as opposed to skipped files
	processedFiles := 0
	for files := files.Oldest(); files != nil; files = files.Next() {
		if files.Value.Skipped != "" {
			continue
		}
		processedFiles++
		riskMap[files.Value.RiskScore] = append(riskMap[files.Value.RiskScore], files.Value.Path)
		for riskLevel := range riskMap {
			riskStats[riskLevel] = (float64(len(riskMap[riskLevel])) / float64(processedFiles)) * 100
		}
	}

	stats := make([]malcontent.IntMetric, 0, len(riskStats))
	total := func() int {
		var t int
		for _, v := range riskMap {
			t += len(v)
		}
		return t
	}
	for k, v := range riskStats {
		stats = append(stats, malcontent.IntMetric{Key: k, Value: v, Count: len(riskMap[k]), Total: total()})
	}
	sort.Slice(stats, func(i, j int) bool {
		return stats[i].Value > stats[j].Value
	})

	return stats, total(), processedFiles
}

func pkgStatistics(files *orderedmap.OrderedMap[string, *malcontent.FileReport]) ([]malcontent.StrMetric, int, int) {
	numNamespaces := 0
	pkgMap := make(map[string]int, files.Len())
	pkg := make(map[string]float64, files.Len())
	for files := files.Oldest(); files != nil; files = files.Next() {
		for _, namespace := range files.Value.Behaviors {
			numNamespaces++
			pkgMap[namespace.ID]++
		}
	}
	for namespace, count := range pkgMap {
		pkg[namespace] = (float64(count) / float64(numNamespaces)) * 100
	}

	width := 10
	for k := range pkg {
		width = func(l int, w int) int {
			if l > w {
				return l
			}
			return w
		}(len(k), width)
	}
	stats := make([]malcontent.StrMetric, 0, len(pkg))
	for k, v := range pkg {
		stats = append(stats, malcontent.StrMetric{Key: k, Value: v, Count: pkgMap[k], Total: numNamespaces})
	}
	sort.Slice(stats, func(i, j int) bool {
		return stats[i].Value > stats[j].Value
	})
	return stats, width, numNamespaces
}

func Statistics(r *malcontent.Report) error {
	riskStats, totalRisks, totalFilesProcessed := riskStatistics(r.Files)
	pkgStats, width, totalPkgs := pkgStatistics(r.Files)

	statsSymbol := "📊"
	riskSymbol := "⚠️ "
	pkgSymbol := "📦"
	fmt.Printf("%s Statistics\n", statsSymbol)
	fmt.Println("---")
	fmt.Printf("\033[1;37m%-15s \033[1;37m%s\033[0m\n", "Files Scanned", fmt.Sprintf("%d (%d skipped)", totalFilesProcessed, r.Files.Len()-totalFilesProcessed))
	fmt.Printf("\033[1;37m%-15s \033[1;37m%s\033[0m\n", "Total Risks", fmt.Sprintf("%d", totalRisks))
	fmt.Println("---")
	fmt.Printf("%s Risk Level Percentage\n", riskSymbol)
	fmt.Println("---")
	fmt.Printf("\033[1;37m%-12s  \033[1;37m%10s %s\033[0m\n", "Risk Level", "Percentage", "Count/Total")
	for _, stat := range riskStats {
		level := ShortRisk(report.RiskLevels[stat.Key])
		color := ""
		switch level {
		case "NONE":
			color = "\033[0m"
		case "LOW":
			color = "\033[32m"
		case "MED":
			color = "\033[33m"
		case "HIGH":
			color = "\033[31m"
		case "CRIT":
			color = "\033[35m"
		}
		fmt.Printf("%s%-12s %10.2f%s %d/%d\033[0m\n", color, fmt.Sprintf("%d/%s", stat.Key, ShortRisk(level)), stat.Value, "%", stat.Count, stat.Total)
	}

	fmt.Println("---")
	fmt.Printf("\033[1;37m%-12s \033[1;37m%10s\033[0m\n", "Total Packages", fmt.Sprintf("%d", totalPkgs))
	fmt.Println("---")
	fmt.Printf("%s Package Risk Percentage\n", pkgSymbol)
	fmt.Println("---")
	fmt.Printf("\033[1;37m%-*s  \033[1;37m%10s %s\033[0m\n", width, "Package", "Percentage", "Count/Total")
	for _, pkg := range pkgStats {
		fmt.Printf("%-*s %10.2f%s %d/%d\n", width, pkg.Key, pkg.Value, "%", pkg.Count, pkg.Total)
	}

	return nil
}
