Return-Path: <SRS0=GX8R=KB=lists.cip-project.org=bounce+64572+6434+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA78C433B4
	for <cip-dev@archiver.kernel.org>; Thu,  6 May 2021 04:46:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E7A610EA
	for <cip-dev@archiver.kernel.org>; Thu,  6 May 2021 04:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E7A610EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6434+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0wg5YY4521723xrW3bJk9LMN; Wed, 05 May 2021 21:46:51 -0700
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2] README.secureboot: Corrections
To: cip-dev@lists.cip-project.org
From: "Dinesh Kumar" <dinesh.kumar@toshiba-tsip.com>
X-Originating-Location: Delhi, National Capital Territory of Delhi, IN (106.215.207.149)
X-Originating-Platform: Windows Chrome 90
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 05 May 2021 21:46:50 -0700
References: <77651949-83ac-5a97-4ccb-b047d9f21867@siemens.com>
In-Reply-To: <77651949-83ac-5a97-4ccb-b047d9f21867@siemens.com>
Message-ID: <1707.1620276410983872256@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GDTzebbjRGNGbq18bZ4J7Tnhx4520388AA=
Content-Type: multipart/mixed; boundary="hF0qVjz5NR0eoixshofF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620276411;
 bh=0MnAngriWi9HfpjKrpmGQufZLdYYNdkTamGOwrMq6v4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=kCYY/oiGV7b7fgOvKsQvbUiURhpW5m/z+lHlk9Xcbs+IQA5Lavt+wRaW+rMU7jfABG1
 0DSJ5ElGugr4ylrxS7CMh4r8BytM3lGSWbp8GpqrjWdSYflxGJIl/Gjj54NOwV1GQ2S+e
 YzUrQ81E6zOjTNVooeB991GmmOiJjZwvLJo=

--hF0qVjz5NR0eoixshofF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May  6, 2021 at 12:24 AM, Quirin Gylstorff wrote:

>
>=20
>=20
> On 5/5/21 6:47 PM, Jan Kiszka wrote:
> > Dinesh, your citation settings are broken. When sending plaintext, as =
it
> > is common on public lists, you need to set the mark "> " at the
> > beginning of all cited line.
> >=20
> > On 30.04.21 16:06, Dinesh Kumar wrote:
> >> On Fri, Apr 30, 2021 at 06:19 AM, Quirin Gylstorff wrote:
> >>
> >>      From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >>
> >>      - Add code block for key insertion for better visibility
> >>      - Correct the template for user-generated keys
> >>      - Add information where to store the keys
> >>
> >>      Add build command for user generated keys
> >>
> >>      Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >>      ---
> >>
> >>      Changes in V2:
> >>      - remove unnecessary new-lines
> >>
> >>      doc/README.secureboot.md | 20 +++++++++++++++-----
> >>      1 file changed, 15 insertions(+), 5 deletions(-)
> >>
> >>      diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> >>      index 84131bb..0996edc 100644
> >>      --- a/doc/README.secureboot.md
> >>      +++ b/doc/README.secureboot.md
> >>      @@ -119,6 +119,7 @@ to the current directory. OVMF_VARS_4M.fd
> >>      contains no keys can be instrumented f
> >>      scripts/start-efishell.sh secureboot-tools
> >>      ```
> >>      4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the
> >>      following steps:
> >>
> >>      +```
> >>
> >> Do you want to mention=C2=A0qemu-system-x86_64 --version should be 5.=
2.0 or
> >> higher as default Debian buster has older version of qemu and this st=
ep
> >> fails with older version.
> >> Also these steps can't be executed remotely as it launches UI window =
for
> >> QEMU, so it should be done locally.
> >=20
> > Feel free to send a patch (or MR if that is easier) that adjust things=
,
> > Dinesh.
> >=20
> >>
> >>      -> "Edit Keys"
> >>      -> "The Allowed Signatures Database (db)"
> >>      -> "Add New Key"
> >>      @@ -132,35 +133,44 @@ scripts/start-efishell.sh secureboot-tools
> >>      -> "Replace Key(s)"
> >>      -> Change/Confirm device
> >>      -> Select "PK.auth" file
> >>      +```
> >>      5. quit QEMU
> >>
> >>      ### Build image
> >>
> >>      Build the image with a signed efibootguard and unified kernel im=
age
> >>      with the snakeoil keys by executing:
> >>      +
> >>      ```
> >>      kas-container build
> >>    =20
> kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/ebg-sec=
ure-boot-snakeoil.yml
> >>      ```
> >>
> >>      -For user-generated keys, create a new option file. This option =
file
> >>      could look like this:
> >>      +For user-generated keys, create a new option file in the
> >>      repository. This option file could look like this:
> >>      ```
> >>      header:
> >>      version: 10
> >>      includes:
> >>      - - opt/ebg-swu.yml
> >>      - - opt/ebg-secure-boot-initramfs.yml
> >>      + - kas/opt/ebg-swu.yml
> >>      + - kas/opt/ebg-secure-boot-base.yml
> >>
> >>      local_conf_header:
> >>      secure-boot: |
> >>      IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-secrets"
> >>      IMAGER_INSTALL +=3D "ebg-secure-boot-secrets"
> >>      - user-keys:
> >>      + user-keys: |
> >>      SB_CERTDB =3D "democertdb"
> >>      SB_VERIFY_CERT =3D "demo.crt"
> >>      SB_KEY_NAME =3D "demo"
> >>      ```
> >>
> >>      -Replace `demo` with the name of the user-generated certificates=
.
> >>      +Replace `demo` with the name of the user-generated certificates=
.
>=20
> I added the following sentence to the README for the keys:
>=20
> The formating is off:
> >>      The user-generated certificates
> >>      +need to stored in the folder
> >>      `recipes-devtools/ebg-secure-boot-secrets/files`.
>=20
>=20
> Dinesh is that sufficient?
   Yes, Quirin, that's sufficient to point it out.
>=20
> Quirin
> >>      +
> >>      +Build the image with user-generated keys by executing the comma=
nd:
> >>      +
> >>      +```
> >>      +kas-container build
> >>      kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:<path t=
o
> >>      the new option>.yml
> >>      +```
> >>
> >>      ### Start the image
> >>
> >> Where are you taking care of my below point? I don't see it yet
> >>
> >>      Keys and certs generated by scripts/generate_secure_boot_keys.sh=
 are
> >>      not available to build command, so I have to move them in
> >>      recipes-devtools/ebg-secure-boot-secrets/files/ folder to make i=
t work
> >>
> >=20
> > Quirin?
> >=20
> > Jan
> >=20
>

--hF0qVjz5NR0eoixshofF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6434): https://lists.cip-project.org/g/cip-dev/message=
/6434
Mute This Topic: https://lists.cip-project.org/mt/82480976/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hF0qVjz5NR0eoixshofF--
