package updates

import (
    "fmt"
    "os"
    "os/exec"
)

// Check for updates and ask the user to update if a new version is available
func Check(owner, repo, tool string) {
    out, err := exec.Command("git", "remote", "update").CombinedOutput()
    if err != nil {
        fmt.Printf("! Failed to check for updates: %v\n", err)
        return
    }
    if len(out) > 0 {
        fmt.Println(string(out))
    }

    out, err = exec.Command("git", "rev-parse", "@{u}").CombinedOutput()
    if err != nil {
        fmt.Printf("! Failed to check for updates: %v\n", err)
        return
    }

    upstream := string(out)

    out, err = exec.Command("git", "rev-parse", "@").CombinedOutput()
    if err != nil {
        fmt.Printf("! Failed to check for updates: %v\n", err)
        return
    }

    local := string(out)

    out, err = exec.Command("git", "merge-base", "@", "@{u}").CombinedOutput()
    if err != nil {
        fmt.Printf("! Failed to check for updates: %v\n", err)
        return
    }

    base := string(out)

    if local == upstream {
        fmt.Printf("Your copy of %s/%s/%s is up-to-date!\n", owner, repo, tool)
        return
    } else if local == base {
        fmt.Printf("An update is available for %s/%s/%s. Run \"go install -v github.com/%s/%s/%s@main\" to update.\n", owner, repo, tool, owner, repo, tool)
    } else {
        fmt.Printf("Your copy of %s/%s/%s is ahead of the upstream version. Nice!\n", owner, repo, tool)
    }
}
