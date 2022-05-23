package main

import (
	"fmt"
	"log"
	"net/http"
	"regexp"
	"strings"

	"github.com/PuerkitoBio/goquery"
)

func Split(r rune) bool {
    return r == "$" || r == 'each' || r == 'per'
}

func parseItem(str string) []string {
	split := strings.Split(str, Split)
	return split
}

func goGet() {
	var headings, row []string
	var rows [][]string

	url := "https://www.foodcoop.com/produce/"
	resp, err := http.Get(url)

	if err != nil {
		log.Fatal(err)
	}
	if resp.StatusCode != 200 {
		log.Fatalf("failed to fetch data: %d %s", resp.StatusCode, resp.Status)
	}

	doc, err := goquery.NewDocumentFromReader(resp.Body)
	if err != nil {
		fmt.Println("No url found")
		log.Fatal(err)
	}

	// Find each table
	doc.Find("table").Each(func(index int, tablehtml *goquery.Selection) {
		tablehtml.Find("tr").Each(func(indextr int, rowhtml *goquery.Selection) {
			rowhtml.Find("th").Each(func(indexth int, tableheading *goquery.Selection) {
				headings = append(headings, tableheading.Text())
			})

			rowhtml.Find("td").Each(func(indexth int, tablecell *goquery.Selection) {

				if len(row) > 1 {
					chars := row[0]
					space := regexp.MustCompile(`\s+`)
					s := space.ReplaceAllString(chars, " ")
					result := strings.TrimSpace(s)
					res := parseItem(result)
					fmt.Println(res[0])
				}
				row = append(row, tablecell.Text())
			})
			rows = append(rows, row)
			row = nil
		})
	})
	defer resp.Body.Close()
}

func main() {
	goGet()
}
