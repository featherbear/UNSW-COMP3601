import os

files = [*filter(lambda p: p.endswith(".txt"), os.listdir())]
for filename in files:
    with open(filename, "r+") as f:
        f.seek(0)
        outBuffer = []
        line = f.readline()
        if "=" not in line: continue

        while line:
            _items = [*map(lambda s: s.strip().split("="), line.split(","))]
            if len(outBuffer) == 0:
                outBuffer.append(",".join([*map(lambda i: i[0], _items)]))
            outBuffer.append(",".join([*map(lambda i: i[1], _items)]))
            line = f.readline()
        with open(filename +".csv", "w") as g:
            g.writelines(map(lambda s: s + "\n", outBuffer))