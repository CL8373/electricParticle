import 'package:electric_field/Particle.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChargedParticleSimulator());
}

class ChargedParticleSimulator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChargedParticleSimulatorScreen(),
    );
  }
}

class ChargedParticleSimulatorScreen extends StatefulWidget {
  @override
  _ChargedParticleSimulatorScreenState createState() => _ChargedParticleSimulatorScreenState();
}

class _ChargedParticleSimulatorScreenState extends State<ChargedParticleSimulatorScreen> with TickerProviderStateMixin {

  late AnimationController _controller;
  late List<FieldParticle> particles = [];

  @override
  void initState() {
    super.initState();
    particles.add(FieldParticle(105, 105, -100));
    particles.add(FieldParticle(120, 120, 200));
    particles[1].mass = 1000;
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
      ..addListener(() {
        for (FieldParticle particle in particles) {
          particle.calculateForce(particles);
        }
        setState(() {});
      });
    
    _controller.repeat();
  }
  
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(
            size: Size(1000, 800),
            painter: ParticlePainter(particles),
            child: Container(),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              ..._getParticlePositions().map((position) {
                return Text(
                position,
                style: TextStyle(color: Colors.white, fontSize: 16),
                );
              }).toList(),
              SizedBox(height: 20),
              ..._getParticleVelocities().map((velocity) {
                return Text(
                velocity,
                style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
                );
                }).toList(),
                SizedBox(height: 20),
                ..._getParticleAccelerations().map((acceleration) {
                return Text(
                acceleration,
                style: TextStyle(color: Colors.yellow, fontSize: 16),
                );
                }).toList(),
                SizedBox(height: 20),
                ..._getParticleForces().map((force) {
                return Text(
                force,
                style: TextStyle(color: Colors.red, fontSize: 16),
                );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getParticlePositions() {
    return particles.map((particle) {
      return 'Particle Position at (${particle.x.toStringAsFixed(1)}, ${particle.y.toStringAsFixed(1)})';
    }).toList();
  }
  List<String> _getParticleVelocities() {
    return particles.map((particle) {
      return 'Particle Velocity (${particle.vx.toStringAsFixed(1)}, ${particle.vy.toStringAsFixed(1)})';
    }).toList();
  }
  List<String> _getParticleAccelerations() {
    return particles.map((particle) {
      return 'Particle Acceleration (${particle.ax.toStringAsFixed(1)}, ${particle.ay.toStringAsFixed(1)})';
    }).toList();
  }
  List<String> _getParticleForces() {
    return particles.map((particle) {
      return 'Particle Force (${particle.fx.toStringAsFixed(1)}, ${particle.fy.toStringAsFixed(1)})';
    }).toList();
  }
}
class Field extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<FieldParticle> particles;
  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (FieldParticle particle in particles) {
      canvas.drawCircle(Offset(particle.x, particle.y), 5, Paint()..color = particle.charge > 0 ? Colors.red : Colors.blue);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
 
 