#!/bin/awk -f

function getAverageGrade(totalScore, numOfAssignments) {
    return totalScore / numOfAssignments
}

# Have to put FS in BEGIN block instead of awk -F, -f since shebang doesn't like that.
BEGIN {
    FS = ","
}

{
    # Skip the header line.
    if (NR == 1) next

    # Uses StudentID as index and stores a student's name.
    name[$1] = $2

    # There might be more than three assignments. Go to end of NF (Number of records).
    # Add up all assignment scores for each student.
    total = 0
    for (i = 3; i <= NF; i++) {
        total += $i
    }
    sum[$1] = total
    # count stores the number of assignments per student (Which might be variable).
    count[$1] = NF - 2
}

END {
    maxScore = -1
    # High value so any score will be below that.
    minScore = 1e9

    for (id in sum) {
        if (sum[id] > maxScore) {
            maxScore = sum[id]
            maxID = id
        }

        if (sum[id] < minScore) {
            minScore = sum[id]
            minID = id
        }
    }

    print "Student", "Total_Score", "Average", "Status"

    for (id in sum) {
        avg = getAverageGrade(sum[id], count[id])
        status = (avg > 70) ? "Pass" : "Fail"
        print name[id], sum[id], avg, status
    }

    print "Top Scorer:", name[maxID], maxScore
    print "Lowest Scorer:", name[minID], minScore
}
