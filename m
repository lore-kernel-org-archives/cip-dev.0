Return-Path: <SRS0=R+ny=GH=lists.cip-project.org=bounce+64572+5987+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB6CC433DB
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:20:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D1A207B3
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D1A207B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5987+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ROG9YY4521723xqNZq6lHnt5; Mon, 04 Jan 2021 02:20:04 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.11576.1609755603302827379
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 02:20:03 -0800
X-IronPort-AV: E=Sophos;i="5.78,473,1599490800"; 
   d="scan'208";a="67985038"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jan 2021 19:20:01 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5FCF6400388B;
	Mon,  4 Jan 2021 19:20:00 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 0/2] dt-bindings: PCI: rcar: Add missing RZ/G2 SoC's
Date: Mon,  4 Jan 2021 10:19:57 +0000
Message-Id: <20210104101959.8182-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: b65jTg29FFPDmXQty0Fznqtgx4520388AA=
Content-Type: multipart/mixed; boundary="fZvjdn0L7hFONQVJqh7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609755604;
 bh=7c2ELyPQSEoBkM7nylFJG22QWX0wUgaGoRp9MwZr/78=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EkkSQWUa+UDIKQT3/M8uhFtr0DNEWPEJjpu697LysA3EU0xKVcTOlDlOyJJzyZ4oSBs
 W35Do/p2EAG8KSs/0WHqnn4pHYom4FxDcuWLJOH3zkPu0QIK2M3BMCQ5v3g8xvZBerB75
 Yq8PpVHOcU5PRiq+g045RQ5pKZbUdl4kGiE=

--fZvjdn0L7hFONQVJqh7f

Hi All,

Both the patches have been cherry picked from v5.11-rc2. Note the DT nodes
for r8a774b1 and r8a774e1 have been already added into CIP it was just the
documentation which was missed earlier.

Cheers,
Prabhakar

Fabrizio Castro (1):
  dt-bindings: PCI: rcar: Add device tree support for r8a774b1

Lad Prabhakar (1):
  dt-bindings: PCI: rcar-pci-host: Document r8a774e1 bindings

 Documentation/devicetree/bindings/pci/rcar-pci.txt | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.17.1


--fZvjdn0L7hFONQVJqh7f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5987): https://lists.cip-project.org/g/cip-dev/message=
/5987
Mute This Topic: https://lists.cip-project.org/mt/79421229/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fZvjdn0L7hFONQVJqh7f--
