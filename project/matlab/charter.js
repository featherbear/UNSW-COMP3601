function charter (elem, csv_url, { variable, keys, title, offScale }) {
  var margin = { top: 0, right: 10, bottom: 40, left: 60 }
  if (title) {
    margin.top += 40
  }
  width = 600 - margin.left - margin.right
  height = 400 - margin.top - margin.bottom

  var svg = d3
    .select(elem)
    .append('div')
    .classed('svg-container', true)
    .append('svg')
    .attr('preserveAspectRatio', 'xMinYMin meet')
    .attr('viewBox', '0 0 600 400')
    .classed('svg-content-responsive', true)
    .append('g')
    .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

  d3.csv(csv_url, function (data) {
    let min = Math.min(...data.map(v => Math.min(...keys.map(k => v[k]))))
    let max = Math.max(...data.map(v => Math.max(...keys.map(k => v[k]))))
    let maxReached = 0

    data = data.filter(d => {
      if (maxReached > 1) return false
      if (keys.every(k => d[k] == max)) {
        maxReached++
      }

      return true
    })

    var x = d3
      .scaleLinear()
      .domain([data[0][variable], data[data.length - 1][variable]])
      .range([0, width])
    svg
      .append('g')
      .attr('transform', 'translate(0,' + height + ')')
      .call(d3.axisBottom(x))

    var y = d3
      .scaleLinear()
      .domain([
        offScale ? min - Math.pow(10, String(min).length - 1) / 2 : 0,
        max + Math.pow(10, String(min).length - 1) / 2
      ])
      .range([height, 0])
    svg.append('g').call(d3.axisLeft(y))

    var bisect = d3.bisector(function (d) {
      return d[variable]
    }).left

    colourMap = ['steelblue', 'orange']

    keys.forEach((k, i) => {
      svg
        .append('path')
        .datum(data)
        .attr('fill', 'none')
        .attr('stroke', colourMap[i])
        .attr('stroke-width', 1.5)
        .attr(
          'd',
          d3
            .line()
            .x(function (d) {
              return x(d[variable])
            })
            .y(function (d) {
              return y(d[k])
            })
        )
    })

    if (title) {
      svg
        .append('text')
        .attr(
          'transform',
          'translate(' + width / 2 + ' ,' + -(margin.top / 2) + ')'
        )
        .style('text-anchor', 'middle')
        .text(title)
    }

    svg
      .append('text')
      .attr(
        'transform',
        'translate(' + width / 2 + ' ,' + (height + margin.bottom - 10) + ')'
      )
      .style('text-anchor', 'middle')
      .text(variable)

    svg
      .append('text')
      .attr('transform', 'rotate(-90)')
      .attr('y', 0 - margin.left)
      .attr('x', 0 - height / 2)
      .attr('dy', '1em')
      .style('text-anchor', 'middle')
      .text('Success Count')

    let foci = keys.map(k =>
      svg
        .append('g')
        .append('circle')
        .style('fill', 'none')
        .attr('stroke', 'black')
        .attr('r', 5.5)
        .style('opacity', 0)
    )

    var focusText = svg
      .append('g')
      .append('text')
      .style('opacity', 0)
      .attr('text-anchor', 'left')
      .attr('alignment-baseline', 'middle')
      .style('white-space', 'pre-line')
      .attr('class', 'focusText')

    svg
      .append('rect')
      .style('fill', 'none')
      .style('pointer-events', 'all')
      .attr('width', width)
      .attr('height', height)
      .on('mouseover', mouseover)
      .on('mousemove', mousemove)
      .on('mouseout', mouseout)

    function mouseover () {
      foci.forEach(elem => elem.style('opacity', 1))
      focusText.style('opacity', 1)
    }

    lastSelect = -1
    function mousemove () {
      var x0 = x.invert(d3.mouse(this)[0])
      var i = bisect(data, x0, 1)
      if (d3.mouse(this)[0] < 5) i = 0
      selectedData = data[i]
      if (!selectedData) return
      if (lastSelect == i) return
      lastSelect = i

      keys.forEach((k, i) => {
        foci[i]
          .attr('cx', x(selectedData[variable]))
          .attr('cy', y(selectedData[k]))
      })
      focusText
        .html(
          [
            `${variable}=${selectedData[variable]}`,
            ...keys.map(
              k =>
                `${k} - ${selectedData[k]} (${Math.round(
                  (selectedData[k] / max) * 1e4
                ) / 1e2}%)`
            )
          ].join('\n')
        )
        .attr(
          'y',
          y((Number(selectedData.M0) + Number(selectedData.M1)) / 2 - 15)
        )

      if (d3.mouse(this)[0] / width > 0.5) {
        focusText.style('transform', `translateX(-25%)`)
      } else {
        focusText.style('transform', 'translateX(0)')
      }

      focusText.attr('x', x(selectedData[variable]) + 15)
    }

    function mouseout () {
      foci.forEach(elem => elem.style('opacity', 0))
      focusText.style('opacity', 0)
    }
  })
}
