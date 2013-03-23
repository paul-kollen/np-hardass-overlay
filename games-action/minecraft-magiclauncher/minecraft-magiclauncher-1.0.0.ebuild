# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils games java-pkg-2

DESCRIPTION="A launcher for Minecraft.  Customize launch parameters, easily load
and unload mods, and manage multiple minecraft versions."
HOMEPAGE="http://www.magiclauncher.com"
SRC_URI="http://www.magiclauncher.com/download.php?f=MagicLauncher-1.0.0.jar -> $P.jar"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="virtual/jdk:1.6"

RDEPEND="games-action/minecraft
	|| ( dev-java/icedtea-bin:6[X]
		dev-java/icedtea:6
		dev-java/sun-jre-bin:1.6[X]
		dev-java/sun-jdk:1.6[X] )"

S="${WORKDIR}"

pkg_setup() {
	java-pkg-2_pkg_setup
	games_pkg_setup
}

src_install() {
	java-pkg_register-dependency minecraft
	java-pkg_dojar "${PN}.jar"

	# Launching with -jar seems to create classpath problems.
	java-pkg_dolauncher "${PN}" -into "${GAMES_PREFIX}"

	doicon "${FILESDIR}/${PN}.svg" || die
	make_desktop_entry "${PN}" "MagicLauncher"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
}