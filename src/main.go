package main

import (
    "fmt"
    "log"
    "net/http"
    "os/exec"
)


func reloadUsbDriverHandler(w http.ResponseWriter, req *http.Request) {
    w.Header().Set("Content-Type", "text/plain")

    _, err := exec.Command("/home/foobargem/sbin/reload_usbdriver.sh").Output()

    if err != nil {
        log.Printf("Error: %s", err)
        w.Write([]byte("Error: "))
        return;
    }

    w.Write([]byte("Reloaded usb driver successfully.\n"))
}


func main() {

    var port = 8020


    http.HandleFunc("/reload-usbdriver", reloadUsbDriverHandler)

    log.Printf("你好~ foobargem messaging server.")
    log.Printf("About to listen on %d. Go to https://127.0.0.1:%d/", port, port)

    err := http.ListenAndServe(fmt.Sprintf(":%d", port), nil)

    if err != nil {
        log.Fatal(err)
    }

}
