## jsontail.rb

Stringify a specifically formatted json log line.

### Usage

```bash
tail -f my.log | ./jsontail.rb
```

### Output

```
<@timestamp|time> <app|@source> [key=value, for all other fields]
```

Nested items will be displayed as `parent1.parent2.key=value`.

