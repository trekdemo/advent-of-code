import { sonar } from './sonar.js'

const measurements = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
test('Counts the increases (simple)', () => {
  expect(sonar()(measurements)).toBe(7);
});

test('Counts the increases (rolling window)', () => {
  expect(sonar(3)(measurements)).toBe(5);
});
