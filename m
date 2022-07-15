X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.3871.1657869794050960984
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:23:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800"; 
   d="scan'208";a="127955832"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:23:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8058340104F7;
	Fri, 15 Jul 2022 16:23:11 +0900 (JST)
From: "Biju Das" <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/24] dmaengine: sh: Kconfig: Add ARCH_R9A07G054 dependency for RZ_DMAC config option
Date: Fri, 15 Jul 2022 08:22:30 +0100
Message-Id: <20220715072244.2298757-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="maccentraleurope"
List-Id: <cip-dev.lists.cip-project.org>

RnJvbTogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMu
Y29tPgoKY29tbWl0IDM4NmZlMDZjMzllODQzYmExYTMyNzRkM2NjNzJmYzg3ODM1YjZjYzkgdXBz
dHJlYW0uCgpSWi9WMkwgRE1BIGJsb2NrIGlzIGlkZW50aWNhbCB0byBvbmUgZm91bmTCoG9uIFJa
L0cyTCBTb0MuIFRoaXMgcGF0Y2ggYWRkcwpBUkNIX1I5QTA3RzA1NCBkZXBlbmRlbmN5IGZvciBS
Wl9ETUFDIGNvbmZpZyBvcHRpb24gc28gdGhhdCB0aGUgZHJpdmVyCmNhbiBiZSBlbmFibGVkIG9u
IFJaL1YyTCBTb0MuIFdoaWxlIGF0IGl0LCBhbHNvIHVwZGF0ZcKgY29uZmlnIGhlbHAgdGV4dC4K
ClNpZ25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBi
cC5yZW5lc2FzLmNvbT4KUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVu
ZXNhc0BnbGlkZXIuYmU+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMjAyMjEy
MjQzMjEuMTE5MzktMS1wcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20KU2ln
bmVkLW9mZi1ieTogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTog
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPgotLS0KIGRyaXZlcnMvZG1hL3No
L0tjb25maWcgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9zaC9LY29uZmlnIGIvZHJpdmVy
cy9kbWEvc2gvS2NvbmZpZwppbmRleCBhNDYyOTYyODUzMDcuLmIzNWQ3MDVmNzllNyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9kbWEvc2gvS2NvbmZpZworKysgYi9kcml2ZXJzL2RtYS9zaC9LY29uZmln
CkBAIC00OSwxMCArNDksMTAgQEAgY29uZmlnIFJFTkVTQVNfVVNCX0RNQUMKIAkgIFNvQ3MuCiAK
IGNvbmZpZyBSWl9ETUFDCi0JdHJpc3RhdGUgIlJlbmVzYXMgUlovRzJMIERNQSBDb250cm9sbGVy
IgotCWRlcGVuZHMgb24gQVJDSF9SOUEwN0cwNDQgfHwgQ09NUElMRV9URVNUCisJdHJpc3RhdGUg
IlJlbmVzYXMgUlove0cyTCxWMkx9IERNQSBDb250cm9sbGVyIgorCWRlcGVuZHMgb24gQVJDSF9S
OUEwN0cwNDQgfHwgQVJDSF9SOUEwN0cwNTQgfHwgQ09NUElMRV9URVNUCiAJc2VsZWN0IFJFTkVT
QVNfRE1BCiAJc2VsZWN0IERNQV9WSVJUVUFMX0NIQU5ORUxTCiAJaGVscAogCSAgVGhpcyBkcml2
ZXIgc3VwcG9ydHMgdGhlIGdlbmVyYWwgcHVycG9zZSBETUEgY29udHJvbGxlciBmb3VuZCBpbiB0
aGUKLQkgIFJlbmVzYXMgUlovRzJMIFNvQyB2YXJpYW50cy4KKwkgIFJlbmVzYXMgUlove0cyTCxW
Mkx9IFNvQyB2YXJpYW50cy4KLS0gCjIuMjUuMQoKCg==
