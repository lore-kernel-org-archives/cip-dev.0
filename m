Return-Path: <alperen.erdogan@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6BEF588E3
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 14:56:33 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH 0/2] swupdate-config-wfx: make device identity configurable
To: cip-dev@lists.cip-project.org
From: "Fatih Alperen Erdogan" <alperen.erdogan@siemens.com>
X-Originating-Location: Vienna, AT (165.225.201.144)
X-Originating-Platform: Windows Edge 147
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 20 Apr 2026 07:56:32 -0700
References: <20260420080018.7091-1-alperen.erdogan@siemens.com> <782e663a-1503-41ca-940e-6f99da8c1a47@siemens.com>
In-Reply-To: <782e663a-1503-41ca-940e-6f99da8c1a47@siemens.com>
Message-ID: <962369.1776696992684909700@lists.cip-project.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Apr 2026 14:56:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22771

On Mon, Apr 20, 2026 at 02:11 AM, Jan Kiszka wrote:

>
> On 20.04.26 10:00, Alperen Erdogan wrote:
> > Add WFX_DEVICE_ID variable to allow configuring the wfx suricatta
> > device identity at build time. Defaults to $(cat /etc/machine-id).
> >=20
> > Alperen Erdogan (2):
> >   swupdate-config-wfx: make device identity configurable
> >   doc: update wfx documentation for configurable device identity
> >=20
> >  doc/README.swupdate.md                                        | 4 ++--
> >  .../swupdate-config-wfx/files/suricatta_wfx.conf.tmpl         | 2 +-
> >  ...{swupdate-config-wfx_0.1.bb =3D> swupdate-config-wfx_0.2.bb} | 4 ++=
+-
> >  3 files changed, 6 insertions(+), 4 deletions(-)
> >  rename recipes-core/swupdate-config-wfx/{swupdate-config-wfx_0.1.bb =
=3D>
> swupdate-config-wfx_0.2.bb} (86%)
> >=20
> > --
> > 2.43.0
> >=20
>=20
> Looks good to me so far - but would you mind explaining your use case as
> well? Do you replace the extraction logic because your target provides
> an production device ID differently, or do you pin it to fixed known
> value in a development image?
>=20
> Jan
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
>

for this use case, target uses a unique device ID provided by the internal =
system, so it=E2=80=99s read from a different file path.

Thanks,=20

Alperen

