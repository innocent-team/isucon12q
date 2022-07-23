package main

import (
	"context"
	"log"

	isuports "github.com/isucon/isucon12-qualify/webapp/go"
)

func main() {
	ctx := context.Background()
	db, err := isuports.ConnectAdminDB()
	if err != nil {
		log.Fatalf("Failed to connect DB: %s", err)
	}
	var competitions []*isuports.CompetitionRow
	err = db.SelectContext(ctx, &competitions, "SELECT * FROM competition")
	if err != nil {
		log.Fatalf("Failed to connect DB: %s", err)
	}

	for _, comp := range competitions {
		if !comp.FinishedAt.Valid {
			continue
		}
		_, err = isuports.UpdateBiliingReport(ctx, comp)
		if err != nil {
			log.Fatalf("Failed to connect DB: %s", err)
		}
	}

	log.Println("Finish")
}
