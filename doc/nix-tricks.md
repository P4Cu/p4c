* ssh pipe'ing

`{ssh} "cat < {remote_file}" | cat > {local_path}`
`tar czf - folder | ssh -T -q  someone@somewhere "cd /path && tar zxf - --touch`,
