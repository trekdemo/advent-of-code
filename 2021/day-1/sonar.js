function eachCons(arr, n) {
  let acc = []

  for (let i = 0; i <= arr.length - n; i++) {
    acc.push(arr.slice(i, i + n))
  }

  return acc
}

function sum(arr) {
  return arr.reduce((a, e) => a + e, 0)
}

export function sonar(movingAvg = 1) {
  return (measurements) => {

    let noise_reduced_measurements = eachCons(measurements, movingAvg).map(sum)
    return eachCons(noise_reduced_measurements, 2)
      .filter(([a, b]) => b > a)
      .length
  }
}
