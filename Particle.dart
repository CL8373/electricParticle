import 'dart:math';

class FieldParticle {
  double x;      // X position
  double y;      // Y position
  double charge; // Charge (positive or negative)
  double vx = 0; // Velocity in X
  double vy = 0; // Velocity in Y
  double mass;   // Mass of the particle
  double radius; // Radius for visual representation
  static const double maxVelocity = 1; // Maximum velocity limit
  static const double interactionDistance = 50; // Distance at which particles influence each other

  FieldParticle(this.x, this.y, this.charge, {this.mass = 1, this.radius = 10});

  void calculateForce(List<FieldParticle> particles) {
    double ax = 0; // Reset acceleration
    double ay = 0;

    for (FieldParticle other in particles) {
      if (other != this) {
        double dx = other.x - x;
        double dy = other.y - y;
        double distance = sqrt(dx * dx + dy * dy);
        // Calculate the force only if the distance is within interaction range
        if (distance < interactionDistance) {
          // Calculate the attractive force using Coulomb's law
          double force = -(charge * other.charge) / (distance * distance);
          double angle = atan2(dy, dx); // Angle towards the other particle

          // Use the force to calculate acceleration
          double fx = force * cos(angle); // Force in the x direction
          double fy = force * sin(angle); // Force in the y direction

          ax += fx / mass; // Update acceleration based on attractive force
          ay += fy / mass; // Update acceleration based on attractive force
        }
      }
    }

    // Update velocities with acceleration
    vx += ax;
    vy += ay;

    // Limit the maximum velocity
    double speed = sqrt(vx * vx + vy * vy);
    if (speed > maxVelocity) {
      vx = (vx / speed) * maxVelocity;
      vy = (vy / speed) * maxVelocity;
    }

    // Update positions
    x += vx;
    y += vy;

    // Bounce off the edges
    if (x < 0 || x > 800) {
      vx = -vx; // Reverse velocity on X boundary
      x = x < 0 ? 0 : 800; // Clamp position within bounds
    }
    if (y < 0 || y > 600) {
      vy = -vy; // Reverse velocity on Y boundary
      y = y < 0 ? 0 : 600; // Clamp position within bounds
    }
  }
}
