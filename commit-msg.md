This PR shows the list of processes that were run during the GitHub Actions pipeline.

The profile is a JSON object with the following syntax:
```json
{
  "mount_ns:/path/to/process:time_stamp": {
    "file_hash": string
  }
}
```

| Field        | Description    |
|:-------------:| ------------- |
| mount_ns     | Mount NameSpace of the process that ran |
| /path/to/process      | Filepath and name of the process that ran      |
| time_stamp | Creation UNIX timestamp of the process that ran      |
| file_hash | A SHA256 checksum of the process binary |


![Tracee Logo](https://github.com/aquasecurity/tracee/raw/main/docs/images/tracee.png)

Powered by [Aqua Security Tracee](https://github.com/aquasecurity/tracee)