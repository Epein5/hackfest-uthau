

def valley(distance):

    ## updates from some old news articles
    if distance <= 5:
        return 20
    elif distance <= 10 & distance > 5:
        return 25
    elif distance <= 15 & distance > 10:
        return 30
    elif distance <= 20 & distance > 15:
        return 33
    else :
        return 38

def longDis(distance):

    ## there was not time to make this calculation more realistic
    ## so we just used a simple formula to calculate the cost

    total_cost = distance * 2.98

    return total_cost
