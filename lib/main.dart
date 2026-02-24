// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const AdaptableDashboardApp());
}

class AdaptableDashboardApp extends StatelessWidget {
  const AdaptableDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard Camaleón',
      
      // Tema Claro
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      
      // Tema Oscuro
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      
      // Escucha al sistema operativo automáticamente
      themeMode: ThemeMode.system,
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery: Obtenemos información global
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      // El color de fondo se adapta automáticamente
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          // LayoutBuilder: Mide el espacio disponible
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Breakpoint: 600px para tablet/web
              if (constraints.maxWidth > 600) {
                return _buildTabletLayout(context);
              } else {
                return _buildMobileLayout(context, screenWidth);
              }
            },
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // DISEÑO PARA MÓVIL (Columna clásica)
  // ==============================================================
  Widget _buildMobileLayout(BuildContext context, double screenWidth) {
    // ignore: duplicate_ignore
    // ignore: prefer_const_constructors
    return SingleChildScrollView(
      // ignore: duplicate_ignore
      // ignore: prefer_const_constructors
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const CustomHeader(),
          const SizedBox(height: 24),
          const BalanceCard(),
          const SizedBox(height: 24),
          const QuickActions(),
          const SizedBox(height: 24),
          const TransactionsList(),
        ],
      ),
    );
  }

  // ==============================================================
  // DISEÑO PARA TABLET/WEB (Fila con dos columnas)
  // ==============================================================
  Widget _buildTabletLayout(BuildContext context) {
    // ignore: duplicate_ignore
    // ignore: prefer_const_constructors
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        // Lado Izquierdo: 40% del espacio
        // ignore: duplicate_ignore
        // ignore: prefer_const_constructors
        Expanded(
          flex: 4,
          // ignore: prefer_const_constructors
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const CustomHeader(),
              const SizedBox(height: 24),
              const BalanceCard(),
              const SizedBox(height: 24),
              const QuickActions(),
            ],
          ),
        ),
        const SizedBox(width: 40),
        // Lado Derecho: 60% del espacio
        Expanded(
          flex: 6,
          child: const TransactionsList(),
        ),
      ],
    );
  }
}

// ==============================================================
// COMPONENTES MODULARES CON COLORES DINÁMICOS
// ==============================================================

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido,',
              style: TextStyle(
                fontSize: 14,
                // ignore: deprecated_member_use
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            Text(
              'Usuario',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(
            Icons.person,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Saldo Total',
              style: TextStyle(
                fontSize: 16,
                // ignore: deprecated_member_use
                color: colorScheme.onPrimary.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$15,789.42',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: colorScheme.onPrimary,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  '+12.5% este mes',
                  style: TextStyle(
                    fontSize: 14,
                    // ignore: deprecated_member_use
                    color: colorScheme.onPrimary.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.spaceEvenly,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        ActionButton(
          iconPath: 'assets/icons/send.svg',
          label: 'Enviar',
          fallbackIcon: Icons.send,
        ),
        ActionButton(
          iconPath: 'assets/icons/receive.svg',
          label: 'Recibir',
          fallbackIcon: Icons.download,
        ),
        ActionButton(
          iconPath: 'assets/icons/pay.svg',
          label: 'Pagar',
          fallbackIcon: Icons.payment,
        ),
        ActionButton(
          iconPath: 'assets/icons/more.svg',
          label: 'Más',
          fallbackIcon: Icons.more_horiz,
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final IconData fallbackIcon;

  const ActionButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.fallbackIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: _buildIcon(colorScheme),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(ColorScheme colorScheme) {
    try {
      return SvgPicture.asset(
        iconPath,
        width: 30,
        height: 30,
        colorFilter: ColorFilter.mode(
          colorScheme.onSecondaryContainer,
          BlendMode.srcIn,
        ),
      );
    } catch (e) {
      // Fallback si el SVG no está disponible
      return Icon(
        fallbackIcon,
        color: colorScheme.onSecondaryContainer,
        size: 30,
      );
    }
  }
}

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Últimas Transacciones',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        const TransactionItem(
          title: 'Netflix',
          subtitle: 'Suscripción mensual',
          amount: '- \$15.99',
          isExpense: true,
          icon: Icons.movie,
        ),
        const TransactionItem(
          title: 'Spotify',
          subtitle: 'Suscripción mensual',
          amount: '- \$9.99',
          isExpense: true,
          icon: Icons.music_note,
        ),
        const TransactionItem(
          title: 'Depósito',
          subtitle: 'Transferencia recibida',
          amount: '+ \$2,500.00',
          isExpense: false,
          icon: Icons.arrow_downward,
        ),
        const TransactionItem(
          title: 'Supermercado',
          subtitle: 'Compra',
          amount: '- \$89.45',
          isExpense: true,
          icon: Icons.shopping_cart,
        ),
      ],
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final bool isExpense;
  final IconData icon;

  const TransactionItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isExpense,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: colorScheme.onPrimaryContainer,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    // ignore: deprecated_member_use
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isExpense ? colorScheme.error : colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}