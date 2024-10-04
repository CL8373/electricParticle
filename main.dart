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
    particles.add(FieldParticle(105, 105, -10));
    particles.add(FieldParticle(120, 120, 10));
    // particles.add(FieldParticle(110, 110, -10));
    // particles.add(FieldParticle(100, 100, 10));
    particles[1].mass = 1000;
    //particles[3].charge = 1000;
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 16))
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
    return CustomPaint(
      size: Size(1000, 800),
      painter: ParticlePainter(particles),
      child: Container(),
    );
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
 
 