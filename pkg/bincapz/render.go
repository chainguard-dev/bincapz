package bincapz

import (
	"fmt"
	"io"
	"os"
	"slices"
	"sort"
	"strings"

	"github.com/olekukonko/tablewriter"
)

type KeyedBehavior struct {
	Key      string
	Behavior Behavior
}

func RenderTable(res *Report, w io.Writer) {
	for path, fr := range res.Files {
		fmt.Printf("%s\n", path)

		kbs := []KeyedBehavior{}
		for k, b := range fr.Behaviors {
			kbs = append(kbs, KeyedBehavior{Key: k, Behavior: b})
		}

		sort.Slice(kbs, func(i, j int) bool {
			if kbs[i].Behavior.RiskScore == kbs[j].Behavior.RiskScore {
				return kbs[i].Key < kbs[j].Key
			}
			return kbs[i].Behavior.RiskScore < kbs[j].Behavior.RiskScore
		})

		data := [][]string{}

		for k, v := range fr.Meta {
			data = append(data, []string{"-", k, v, ""})
		}
		data = append(data, []string{"", "", "", ""})

		for _, k := range kbs {
			val := strings.Join(k.Behavior.Strings, " ")
			if len(val) > 48 {
				val = val[0:48] + ".."
			}
			data = append(data, []string{fmt.Sprintf("%d/%s", k.Behavior.RiskScore, k.Behavior.RiskLevel), k.Key, val, k.Behavior.Description})
		}
		table := tablewriter.NewWriter(os.Stdout)
		table.SetAutoWrapText(false)
		table.SetHeader([]string{"Risk", "Key", "Values", "Description"})
		//table.SetBorder(false)
		table.AppendBulk(data) // Add Bulk Data
		table.Render()

		if fr.FilteredBehaviors > 0 {
			fmt.Fprintf(w, "\n# %d behavior(s) filtered out, use --all to see more\n", fr.FilteredBehaviors)
		}
	}
}

func RenderSimple(res *Report, w io.Writer) {
	for path, fr := range res.Files {
		fmt.Fprintf(w, "# %s\n", path)
		keys := []string{}
		for key := range fr.Behaviors {
			keys = append(keys, key)
		}
		slices.Sort(keys)
		for _, key := range keys {
			fmt.Fprintf(w, "- %s\n", key)
		}

		if fr.FilteredBehaviors > 0 {
			fmt.Fprintf(w, "\n# %d behavior(s) filtered out, use --all to see more\n", fr.FilteredBehaviors)
		}
	}
}
