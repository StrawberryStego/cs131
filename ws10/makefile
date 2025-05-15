RAW := raw.csv
TRIM := trimmed.csv
CLEAN := clean.csv

all: $(CLEAN)

# Select id (field 1), age (field 3), score (field 5)
$(TRIM): $(RAW)
	cut -d, -f1,3,5 $< > $@

# Drop rows where age or score is empty
$(CLEAN): $(TRIM)
    # Strip out any trailing characters for rows.
	tr -d '\r' < "$<" | \
	awk -F, 'NF==3 && length($$2)>0 && length($$3)>0' > "$@"

# Remove intermediate files
.PHONY: clean
clean:
	rm -f $(TRIM)
	rm -f $(CLEAN)
