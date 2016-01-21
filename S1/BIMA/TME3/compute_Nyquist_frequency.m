function fn = compute_Nyquist_frequency(theta, T0)
  fn = max(2* (1/T0) * cos(degtorad(theta)), 2 * (1/T0) * sin(degtorad(theta)));
end
