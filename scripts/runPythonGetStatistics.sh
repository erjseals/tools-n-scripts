#!/bin/bash

# Expects python file to output a number to std out, like "1.92" in seconds

# Number of times to run the script
NUM_RUNS=100
PYTHON_SCRIPT="extra/scripts/lit_test_query.py --output test/lit/staging-set.txt --build"
TIMES=()

# Run the Python script 20 times and store the execution times
for ((i=1; i<=NUM_RUNS; i++))
do
    # Run the Python script and capture the execution time
    TIME=$(python3 $PYTHON_SCRIPT)
    
    # Add the time to the array
    TIMES+=($TIME)
    
    echo "Run #$i: $TIME seconds"
done

# Calculate statistics
TOTAL=0
MIN=${TIMES[0]}
MAX=${TIMES[0]}

for TIME in "${TIMES[@]}"
do
    TOTAL=$(echo "$TOTAL + $TIME" | bc)
    
    if (( $(echo "$TIME < $MIN" | bc -l) )); then
        MIN=$TIME
    fi
    
    if (( $(echo "$TIME > $MAX" | bc -l) )); then
        MAX=$TIME
    fi
done

# Calculate average
AVERAGE=$(echo "$TOTAL / $NUM_RUNS" | bc -l)

# Calculate variance and standard deviation
SUM_SQ_DIFFS=0

for TIME in "${TIMES[@]}"
do
    DIFF=$(echo "$TIME - $AVERAGE" | bc -l)
    SQUARE_DIFF=$(echo "$DIFF * $DIFF" | bc -l)
    SUM_SQ_DIFFS=$(echo "$SUM_SQ_DIFFS + $SQUARE_DIFF" | bc -l)
done

VARIANCE=$(echo "$SUM_SQ_DIFFS / $NUM_RUNS" | bc -l)
STD_DEV=$(echo "scale=2; sqrt($VARIANCE)" | bc -l)

# Output statistics
echo "-------------------------------"
echo "Statistics after $NUM_RUNS runs:"
echo "Minimum Time: $MIN seconds"
echo "Maximum Time: $MAX seconds"
echo "Average Time: $AVERAGE seconds"
echo "Standard Deviation: $STD_DEV seconds"


