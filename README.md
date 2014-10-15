## jsontail.rb

Stringify a specifically formatted json log line.

### Usage

```bash
tail -f my.log | ./jsontail.rb
```

### Output

```
@timestamp host LEVEL application pid "message" - field1=value1 - nested.field2=value2 ...
```

Nested items will be displayed as `parent1.parent2.key=value`.

