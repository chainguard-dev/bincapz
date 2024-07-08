package report

import (
	"reflect"
	"testing"
)

func TestLongestUnique(t *testing.T) {
	tests := []struct {
		name string
		raw  []string
		want []string
	}{
		{
			name: "Test 1",
			raw:  []string{"apple", "banana", "cherry", "applecherry", "bananaapple", "cherrybanana"},
			want: []string{"applecherry", "bananaapple", "cherrybanana"},
		},
		{
			name: "Test 2",
			raw:  []string{"test", "testing", "tester", "testest"},
			want: []string{"testing", "tester", "testest"},
		},
		{
			name: "Test 3",
			raw:  []string{"", "a", "aa", "aaa"},
			want: []string{"aaa"},
		},
		{
			name: "Test 4",
			raw:  []string{"abc", "def", "ghi"},
			want: []string{"abc", "def", "ghi"},
		},
		{
			name: "Test 5",
			raw:  []string{"abc", "abcabc", "abcabcabc"},
			want: []string{"abcabcabc"},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := longestUnique(tt.raw); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("longestUnique() = %v, want %v", got, tt.want)
			}
		})
	}
}

func BenchmarkLongestUnique(b *testing.B) {
	raw := []string{
		"_proc_download_content",
		"apple",
		"applecherry",
		"banana",
		"bananaapple",
		"cherry",
		"cherrybanana",
		"upload_content",
	}
	for i := 0; i < b.N; i++ {
		longestUnique(raw)
	}
}

func TestAll(t *testing.T) {
	tests := []struct {
		name       string
		conditions []bool
		want       bool
	}{
		{
			name:       "All True",
			conditions: []bool{true, true, true, true},
			want:       true,
		},
		{
			name:       "All False",
			conditions: []bool{false, false, false, false},
			want:       false,
		},
		{
			name:       "One True; Many False",
			conditions: []bool{true, false, false, false},
			want:       false,
		},
		{
			name:       "Many True; One False",
			conditions: []bool{true, true, true, false},
			want:       false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := all(tt.conditions...); got != tt.want {
				t.Errorf("all() = %v, want %v", got, tt.want)
			}
		})
	}
}
