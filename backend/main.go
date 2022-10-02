package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
	"github.com/tanimutomo/sqlfile"
	"log"
	"net/http"
	"os"
	"time"
)

func connect() (*sql.DB, error) {
	bin := "db-brians"
	return sql.Open("postgres", fmt.Sprintf("postgres://postgres:%s@db:5432/example?sslmode=disable", bin)) //string(bin)))
}

func blogHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	db, err := connect()
	if err != nil {
		w.WriteHeader(500)
		return
	}
	defer db.Close()

	rows, err := db.Query("SELECT title FROM blog")
	if err != nil {
		w.WriteHeader(500)
		return
	}
	//var titles []string
	mapObject := map[string]int{}
	sum := 1
	
	for rows.Next() {
		var title string
		err = rows.Scan(&title)
		mapObject[title] = sum
		sum += 1
	}
	json.NewEncoder(w).Encode(mapObject)
}

func main() {
	log.Print("Prepare db...")
	if err := prepare(); err != nil {
		log.Fatal(err)
	}

	log.Print("Listening 8000")
	r := mux.NewRouter()
	r.HandleFunc("/", blogHandler)
	log.Fatal(http.ListenAndServe(":8000", handlers.LoggingHandler(os.Stdout, r)))
}

func prepare() error {
	db, err := connect()
	if err != nil {
		return err
	}
	defer db.Close()

	for i := 0; i < 5; i++ {
		if err := db.Ping(); err == nil {
			break
		}
		time.Sleep(time.Second)
	}

	log.Print("Prepare drop table...")

	if _, err := db.Exec("DROP TABLE IF EXISTS blog"); err != nil {
		return err
	}

	s := sqlfile.New()

	err = s.File("create_tables.sql")

	if err != nil {
		return err
	}

	log.Print("create db...")

	err = s.File("insert_records.sql")

	if err != nil {
		return err
	}

	_, err = s.Exec(db)

	if err != nil {
		return err
	}

	return nil
}
