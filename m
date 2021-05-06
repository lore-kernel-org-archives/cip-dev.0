Return-Path: <SRS0=4A99=KB=lists.cip-project.org=bounce+64572+6433+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D010DC433B4
	for <cip-dev@archiver.kernel.org>; Thu,  6 May 2021 04:39:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36414613B5
	for <cip-dev@archiver.kernel.org>; Thu,  6 May 2021 04:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36414613B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6433+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MrdrYY4521723xvIyfBIFY6I; Wed, 05 May 2021 21:39:05 -0700
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2] README.secureboot: Corrections
To: cip-dev@lists.cip-project.org
From: "Dinesh Kumar" <dinesh.kumar@toshiba-tsip.com>
X-Originating-Location: Delhi, National Capital Territory of Delhi, IN (106.215.207.149)
X-Originating-Platform: Windows Chrome 90
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 05 May 2021 21:39:05 -0700
References: <9c3ef309-f2e8-0624-a118-d3e375d40559@siemens.com>
In-Reply-To: <9c3ef309-f2e8-0624-a118-d3e375d40559@siemens.com>
Message-ID: <3359.1620275945325684568@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VJluTTBKI8V8qYSF51xqbQOmx4520388AA=
Content-Type: multipart/mixed; boundary="1iWOy6MUrriFt8ZjtjuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620275945;
 bh=FtibY9FluDXWdlA6XgQwt9tlNY6MLvV3txm2e0FjJA0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=UEH2IfKwfvRSbHzjGx/B3ANCYxsrufKzfi52ZecOrsmjDlzRVNgmfvWP9YeFoNyjGpp
 80p6VtI7ONpA5cbihFLwn4+fVUcbrxNtEfboplvrbdmRs5t8tdS4pFP/IFom++IgXVcS+
 ACpz4J89bMNToWiHU9sRIdV2raZkpJu/Opg=

--1iWOy6MUrriFt8ZjtjuP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May  5, 2021 at 10:17 PM, Jan Kiszka wrote:

>
> Dinesh, your citation settings are broken. When sending plaintext, as it
> is common on public lists, you need to set the mark "> " at the
> beginning of all cited line.

Yes, just now I have changed settings and made it plaintext while replying=
, earlier it was HTML. I hope it will fix this issue.
Thanks for pointing it.

> On 30.04.21 16:06, Dinesh Kumar wrote:
> > On Fri, Apr 30, 2021 at 06:19 AM, Quirin Gylstorff wrote:
> >=20
> >     From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >=20
> >     - Add code block for key insertion for better visibility
> >     - Correct the template for user-generated keys
> >     - Add information where to store the keys
> >=20
> >     Add build command for user generated keys
> >=20
> >     Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >     ---
> >=20
> >     Changes in V2:
> >     - remove unnecessary new-lines
> >=20
> >     doc/README.secureboot.md | 20 +++++++++++++++-----
> >     1 file changed, 15 insertions(+), 5 deletions(-)
> >=20
> >     diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> >     index 84131bb..0996edc 100644
> >     --- a/doc/README.secureboot.md
> >     +++ b/doc/README.secureboot.md
> >     @@ -119,6 +119,7 @@ to the current directory. OVMF_VARS_4M.fd
> >     contains no keys can be instrumented f
> >     scripts/start-efishell.sh secureboot-tools
> >     ```
> >     4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the
> >     following steps:
> >=20
> >     +```
> >=20
> > Do you want to mention=C2=A0qemu-system-x86_64 --version should be 5.2=
.0 or
> > higher as default Debian buster has older version of qemu and this ste=
p
> > fails with older version.
> > Also these steps can't be executed remotely as it launches UI window f=
or
> > QEMU, so it should be done locally.
>=20
> Feel free to send a patch (or MR if that is easier) that adjust things,
> Dinesh.
   Sure, I will do that.
> >=20
> >     -> "Edit Keys"
> >     -> "The Allowed Signatures Database (db)"
> >     -> "Add New Key"
> >     @@ -132,35 +133,44 @@ scripts/start-efishell.sh secureboot-tools
> >     -> "Replace Key(s)"
> >     -> Change/Confirm device
> >     -> Select "PK.auth" file
> >     +```
> >     5. quit QEMU
> >=20
> >     ### Build image
> >=20
> >     Build the image with a signed efibootguard and unified kernel imag=
e
> >     with the snakeoil keys by executing:
> >     +
> >     ```
> >     kas-container build
> >    
> kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/ebg-sec=
ure-boot-snakeoil.yml
> >     ```
> >=20
> >     -For user-generated keys, create a new option file. This option fi=
le
> >     could look like this:
> >     +For user-generated keys, create a new option file in the
> >     repository. This option file could look like this:
> >     ```
> >     header:
> >     version: 10
> >     includes:
> >     - - opt/ebg-swu.yml
> >     - - opt/ebg-secure-boot-initramfs.yml
> >     + - kas/opt/ebg-swu.yml
> >     + - kas/opt/ebg-secure-boot-base.yml
> >=20
> >     local_conf_header:
> >     secure-boot: |
> >     IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-secrets"
> >     IMAGER_INSTALL +=3D "ebg-secure-boot-secrets"
> >     - user-keys:
> >     + user-keys: |
> >     SB_CERTDB =3D "democertdb"
> >     SB_VERIFY_CERT =3D "demo.crt"
> >     SB_KEY_NAME =3D "demo"
> >     ```
> >=20
> >     -Replace `demo` with the name of the user-generated certificates.
> >     +Replace `demo` with the name of the user-generated certificates.
> >     The user-generated certificates
> >     +need to stored in the folder
> >     `recipes-devtools/ebg-secure-boot-secrets/files`.
> >     +
> >     +Build the image with user-generated keys by executing the command=
:
> >     +
> >     +```
> >     +kas-container build
> >     kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:<path to
> >     the new option>.yml
> >     +```
> >=20
> >     ### Start the image
> >=20
> > Where are you taking care of my below point? I don't see it yet
> >=20
> >     Keys and certs generated by scripts/generate_secure_boot_keys.sh a=
re
> >     not available to build command, so I have to move them in
> >     recipes-devtools/ebg-secure-boot-secrets/files/ folder to make it =
work
> >=20
>=20
> Quirin?
>=20
> Jan
>=20
> --=20
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>

--1iWOy6MUrriFt8ZjtjuP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6433): https://lists.cip-project.org/g/cip-dev/message=
/6433
Mute This Topic: https://lists.cip-project.org/mt/82480976/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1iWOy6MUrriFt8ZjtjuP--
