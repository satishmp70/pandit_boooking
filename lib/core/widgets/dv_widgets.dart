import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../theme/dv_theme.dart';

/// Real Material app bar used by [DvScaffold]. Back navigation goes through
/// go_router, and the system status bar is drawn by the OS (not by the app).
class DvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DvAppBar({
    this.title = '',
    this.backPath,
    this.rightLabel,
    this.onRight,
    super.key,
  });

  final String title;
  final String? backPath;
  final String? rightLabel;
  final VoidCallback? onRight;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: DvColors.appBg,
      foregroundColor: DvColors.ink,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leadingWidth: 56,
      leading: backPath == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                onPressed: () => context.go(backPath!),
                icon: const Icon(Icons.chevron_left, size: 26),
                tooltip: 'Back',
              ),
            ),
      title: Text(
        title,
        style: DvText.body(
          size: 16,
          weight: FontWeight.w700,
          color: DvColors.ink,
        ),
      ),
      actions: rightLabel == null
          ? null
          : [
              TextButton(
                onPressed: onRight,
                child: Text(
                  rightLabel!,
                  style: DvText.body(
                    size: 12,
                    weight: FontWeight.w700,
                    color: DvColors.kum,
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],
    );
  }
}

class DvWizard extends StatelessWidget {
  const DvWizard({required this.step, super.key});

  final int step;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
      child: Row(
        children: [
          for (var i = 1; i <= 4; i++)
            Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: i == 4 ? 0 : 6),
                decoration: BoxDecoration(
                  color: i <= step ? DvColors.kum : DvColors.line,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DvTabBar extends StatelessWidget {
  const DvTabBar({required this.active, super.key});

  final String active;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: DvColors.surface,
        border: Border(top: BorderSide(color: DvColors.line)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: 76,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _tab(
                  context,
                  'home',
                  Icons.wb_sunny_outlined,
                  'Home',
                  Routes.homePath,
                ),
                _tab(
                  context,
                  'bookings',
                  Icons.calendar_today_outlined,
                  'Bookings',
                  Routes.bookingsPath,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.go(Routes.conciergePath),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -22),
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFC4402F), Color(0xFF96262A)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _tab(
                  context,
                  'family',
                  Icons.family_restroom,
                  'Family',
                  Routes.familyPath,
                ),
                _tab(
                  context,
                  'account',
                  Icons.person_outline,
                  'Account',
                  Routes.accountPath,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tab(
    BuildContext context,
    String key,
    IconData icon,
    String label,
    String path,
  ) {
    final on = active == key;
    final color = on ? DvColors.kum : DvColors.ink3;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.go(path),
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: DvText.body(
                size: 9.5,
                weight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DvCta extends StatelessWidget {
  const DvCta({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
      decoration: const BoxDecoration(
        color: DvColors.appBg,
        border: Border(top: BorderSide(color: DvColors.line)),
      ),
      child: child,
    );
  }
}

class DvScaffold extends StatelessWidget {
  const DvScaffold({
    required this.child,
    this.title,
    this.backPath,
    this.rightLabel,
    this.onRight,
    this.wizardStep = 0,
    this.tab,
    this.cta,
    this.padded = true,
    this.bottomPadding = 22,
    super.key,
  });

  final Widget child;
  final String? title;
  final String? backPath;
  final String? rightLabel;
  final VoidCallback? onRight;
  final int wizardStep;
  final String? tab;
  final Widget? cta;
  final bool padded;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final hasNav = title != null || backPath != null || rightLabel != null;
    return Scaffold(
      backgroundColor: DvColors.appBg,
      appBar: hasNav
          ? DvAppBar(
              title: title ?? '',
              backPath: backPath,
              rightLabel: rightLabel,
              onRight: onRight,
            )
          : null,
      body: SafeArea(
        top: !hasNav,
        bottom: false,
        child: Column(
          children: [
            if (wizardStep > 0) DvWizard(step: wizardStep),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  padded ? 18 : 0,
                  8,
                  padded ? 18 : 0,
                  bottomPadding,
                ),
                child: child,
              ),
            ),
            if (cta != null) DvCta(child: cta!),
          ],
        ),
      ),
      bottomNavigationBar: tab != null ? DvTabBar(active: tab!) : null,
    );
  }
}

class DvCard extends StatelessWidget {
  const DvCard({
    required this.child,
    this.padding = const EdgeInsets.all(15),
    this.color = DvColors.surface,
    this.borderColor = DvColors.line,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final Color borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(17),
      ),
      child: child,
    );
    if (onTap == null) return content;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: content,
    );
  }
}

enum DvTone { green, brass, kum, neutral, indigo, amber }

class DvPill extends StatelessWidget {
  const DvPill(this.text, {this.tone = DvTone.neutral, super.key});

  final String text;
  final DvTone tone;

  @override
  Widget build(BuildContext context) {
    late final Color bg;
    late final Color fg;
    switch (tone) {
      case DvTone.green:
        bg = DvColors.greenSoft;
        fg = DvColors.green;
        break;
      case DvTone.brass:
        bg = DvColors.brassSoft;
        fg = DvColors.brass;
        break;
      case DvTone.kum:
        bg = DvColors.kumSoft;
        fg = DvColors.kum;
        break;
      case DvTone.indigo:
        bg = DvColors.indigo;
        fg = Colors.white;
        break;
      case DvTone.amber:
        bg = DvColors.amberSoft;
        fg = DvColors.amber;
        break;
      case DvTone.neutral:
        bg = DvColors.line2;
        fg = DvColors.ink2;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: DvText.body(size: 10.5, weight: FontWeight.w700, color: fg),
      ),
    );
  }
}

class DvChip extends StatelessWidget {
  const DvChip(this.label, {this.selected = false, this.onTap, super.key});

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? DvColors.kum : DvColors.surface,
          border: Border.all(color: selected ? DvColors.kum : DvColors.line),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: DvText.body(
            size: 12.5,
            weight: FontWeight.w600,
            color: selected ? Colors.white : DvColors.ink2,
          ),
        ),
      ),
    );
  }
}

class DvChipRow extends StatelessWidget {
  const DvChipRow({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            children[i],
          ],
        ],
      ),
    );
  }
}

class DvSectionLabel extends StatelessWidget {
  const DvSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(text.toUpperCase(), style: DvText.eyebrow()),
    );
  }
}

class DvBanner extends StatelessWidget {
  const DvBanner({
    required this.title,
    required this.body,
    this.icon = Icons.info_outline,
    this.tone = DvTone.amber,
    super.key,
  });

  final String title;
  final String body;
  final IconData icon;
  final DvTone tone;

  @override
  Widget build(BuildContext context) {
    late final Color bg;
    late final Color accent;
    switch (tone) {
      case DvTone.green:
        bg = DvColors.greenSoft;
        accent = DvColors.green;
        break;
      case DvTone.kum:
        bg = DvColors.kumSoft;
        accent = DvColors.kum;
        break;
      case DvTone.brass:
        bg = DvColors.brassSoft;
        accent = DvColors.brass;
        break;
      default:
        bg = DvColors.amberSoft;
        accent = DvColors.amber;
        break;
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: accent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: DvText.body(
                    size: 12.5,
                    weight: FontWeight.w700,
                    color: DvColors.ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: DvText.body(
                    size: 12,
                    color: DvColors.ink2,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DvMoneyRow extends StatelessWidget {
  const DvMoneyRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.total = false,
    this.discount = false,
    super.key,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool total;
  final bool discount;

  @override
  Widget build(BuildContext context) {
    final labelStyle = total
        ? DvText.body(size: 14, weight: FontWeight.w700, color: DvColors.ink)
        : DvText.body(
            size: 12.5,
            color: discount ? DvColors.green : DvColors.ink2,
          );
    final valueStyle = total
        ? DvText.mono(size: 15, weight: FontWeight.w700, color: DvColors.ink)
        : DvText.mono(
            size: 13,
            weight: FontWeight.w600,
            color: valueColor ?? (discount ? DvColors.green : DvColors.ink),
          );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: labelStyle)),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}

enum DvStepState { done, now, idle }

class DvStepRow extends StatelessWidget {
  const DvStepRow({
    required this.title,
    required this.subtitle,
    this.state = DvStepState.idle,
    this.last = false,
    super.key,
  });

  final String title;
  final String subtitle;
  final DvStepState state;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final done = state == DvStepState.done;
    final now = state == DvStepState.now;
    final circleColor = done
        ? DvColors.green
        : (now ? DvColors.kum : DvColors.line);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: done
                      ? DvColors.greenSoft
                      : (now ? DvColors.kumSoft : DvColors.line2),
                  border: Border.all(color: circleColor, width: 1.4),
                  shape: BoxShape.circle,
                ),
                child: done
                    ? const Icon(Icons.check, size: 13, color: DvColors.green)
                    : (now
                          ? Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: DvColors.kum,
                                shape: BoxShape.circle,
                              ),
                            )
                          : null),
              ),
              if (!last)
                Expanded(
                  child: Container(
                    width: 1.4,
                    color: done ? DvColors.green : DvColors.line,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: last ? 4 : 16, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: DvText.body(
                      size: 13,
                      weight: FontWeight.w700,
                      color: state == DvStepState.idle
                          ? DvColors.ink3
                          : DvColors.ink,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: DvText.body(size: 11.5, color: DvColors.ink3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DvProgressBar extends StatelessWidget {
  const DvProgressBar({required this.value, this.danger = false, super.key});

  final double value;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 7,
        color: DvColors.line2,
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: value.clamp(0, 1),
          child: Container(color: danger ? DvColors.kum : DvColors.green),
        ),
      ),
    );
  }
}

class DvStars extends StatelessWidget {
  const DvStars(this.count, {this.size = 13, super.key});

  final int count;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 5; i++)
          Icon(
            i < count ? Icons.star : Icons.star_border,
            size: size,
            color: DvColors.brass,
          ),
      ],
    );
  }
}

class DvAvatar extends StatelessWidget {
  const DvAvatar(
    this.initials, {
    this.tone = DvTone.kum,
    this.size = 42,
    super.key,
  });

  final String initials;
  final DvTone tone;
  final double size;

  @override
  Widget build(BuildContext context) {
    late final Color bg;
    late final Color fg;
    switch (tone) {
      case DvTone.kum:
        bg = DvColors.kumSoft;
        fg = DvColors.kum;
        break;
      case DvTone.indigo:
        bg = DvColors.indigo;
        fg = Colors.white;
        break;
      case DvTone.green:
        bg = DvColors.greenSoft;
        fg = DvColors.green;
        break;
      case DvTone.brass:
        bg = DvColors.brassSoft;
        fg = DvColors.brass;
        break;
      default:
        bg = DvColors.line2;
        fg = DvColors.ink2;
        break;
    }
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Text(
        initials,
        style: DvText.body(
          size: size * 0.32,
          weight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}

class DvOptionRow extends StatelessWidget {
  const DvOptionRow({
    required this.selected,
    required this.child,
    this.onTap,
    super.key,
  });

  final bool selected;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: DvColors.surface,
          border: Border.all(
            color: selected ? DvColors.kum : DvColors.line,
            width: selected ? 1.4 : 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 18,
              height: 18,
              margin: const EdgeInsets.only(top: 1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? DvColors.kum : DvColors.line,
                  width: 1.6,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          color: DvColors.kum,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 11),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class DvField extends StatelessWidget {
  const DvField({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: DvColors.surface,
        border: Border.all(color: DvColors.line),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: DvText.eyebrow()),
          const SizedBox(height: 3),
          Text(
            value,
            style: DvText.body(
              size: 13.5,
              weight: FontWeight.w600,
              color: DvColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class DvDivider extends StatelessWidget {
  const DvDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(height: 1, thickness: 1, color: DvColors.line2),
    );
  }
}

enum DvButtonVariant { primary, ghost, indigo }

class DvButton extends StatelessWidget {
  const DvButton({
    required this.label,
    this.onTap,
    this.variant = DvButtonVariant.primary,
    this.small = false,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onTap;
  final DvButtonVariant variant;
  final bool small;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final height = small ? 40.0 : 50.0;
    late final BoxDecoration decoration;
    late final Color fg;
    switch (variant) {
      case DvButtonVariant.primary:
        decoration = BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFC4402F), Color(0xFF96262A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(small ? 12 : 15),
        );
        fg = Colors.white;
        break;
      case DvButtonVariant.indigo:
        decoration = BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF312A63), Color(0xFF1C1838)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(small ? 12 : 15),
        );
        fg = Colors.white;
        break;
      case DvButtonVariant.ghost:
        decoration = BoxDecoration(
          border: Border.all(color: DvColors.line, width: 1.5),
          borderRadius: BorderRadius.circular(small ? 12 : 15),
        );
        fg = DvColors.ink;
        break;
    }
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: height,
        alignment: Alignment.center,
        decoration: decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: small ? 16 : 18, color: fg),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: DvText.body(
                size: small ? 13 : 15,
                weight: FontWeight.w700,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DvHero extends StatelessWidget {
  const DvHero({required this.child, this.radiusBottom = 26, super.key});

  final Widget child;
  final double radiusBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        18,
        8 + MediaQuery.of(context).padding.top,
        18,
        18,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [DvColors.heroStart, DvColors.heroEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(radiusBottom),
        ),
      ),
      child: child,
    );
  }
}
