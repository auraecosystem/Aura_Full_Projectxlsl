package main

import (
	"encoding/xml"
	"fmt"
	"os"
)

type Types struct {
	Defaults []Default `xml:"Default"`
}

type Default struct {
	Extension string `xml:"Extension,attr"`
}

func main() {
	file, _ := os.Open("[Content_Types].xml")
	defer file.Close()

	var types Types
	xml.NewDecoder(file).Decode(&types)

	for _, d := range types.Defaults {
		fmt.Println(d.Extension)
	}
}
