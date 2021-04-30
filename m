Return-Path: <SRS0=8svA=J3=lists.cip-project.org=bounce+64572+6409+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C30C433B4
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 14:06:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEE261407
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 14:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEE261407
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6409+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Nzp6YY4521723xuJVm1BVPZv; Fri, 30 Apr 2021 07:06:24 -0700
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2] README.secureboot: Corrections
To: cip-dev@lists.cip-project.org
From: "Dinesh Kumar" <dinesh.kumar@toshiba-tsip.com>
X-Originating-Location: Meerut, Uttar Pradesh, IN (106.215.238.32)
X-Originating-Platform: Windows Chrome 89
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 30 Apr 2021 07:06:24 -0700
References: <20210430131519.23750-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210430131519.23750-1-Quirin.Gylstorff@siemens.com>
Message-ID: <18306.1619791584153988370@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NYzRKpdnfmnKUc9ugdjpvj3xx4520388AA=
Content-Type: multipart/mixed; boundary="tfUVqiMwbxspXsu6cqjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619791584;
 bh=SCAdJGBmhhlbvdliX0FWUhM3rRLa2UI04oTx6jrzMfo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=qKVWF22DdxS9NbJnerQEfFID6KTTnd+rTAtwJQRhsPN1Nbl+W9onQ6HGfqEx+izIE64
 OOvWAI//rByBTGGHYqJqdZ37mkfCY1eIus51/wvFiypXZB74PzTa4U+zmdm2KjHrKVGHw
 nXQWMQG8RfOJMuHMqK2ojoQ7ZN7CQd92YkI=

--tfUVqiMwbxspXsu6cqjj
Content-Type: multipart/alternative; boundary="3P4pK14WpdMWOhEfQG8s"

--3P4pK14WpdMWOhEfQG8s
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 30, 2021 at 06:19 AM, Quirin Gylstorff wrote:

>=20
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> - Add code block for key insertion for better visibility
> - Correct the template for user-generated keys
> - Add information where to store the keys
>=20
> Add build command for user generated keys
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>=20
> Changes in V2:
> - remove unnecessary new-lines
>=20
> doc/README.secureboot.md | 20 +++++++++++++++-----
> 1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 84131bb..0996edc 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -119,6 +119,7 @@ to the current directory. OVMF_VARS_4M.fd contains n=
o
> keys can be instrumented f
> scripts/start-efishell.sh secureboot-tools
> ```
> 4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the following
> steps:

>=20
> +```

Do you want to mention=C2=A0qemu-system-x86_64 --version should be 5.2.0 o=
r higher as default Debian buster has older version of qemu and this step f=
ails with older version.
Also these steps can't be executed remotely as it launches UI window for Q=
EMU, so it should be done locally.

>=20
> -> "Edit Keys"
> -> "The Allowed Signatures Database (db)"
> -> "Add New Key"
> @@ -132,35 +133,44 @@ scripts/start-efishell.sh secureboot-tools
> -> "Replace Key(s)"
> -> Change/Confirm device
> -> Select "PK.auth" file
> +```
> 5. quit QEMU
>=20
> ### Build image
>=20
> Build the image with a signed efibootguard and unified kernel image
> with the snakeoil keys by executing:
> +
> ```
> kas-container build
> kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/ebg-sec=
ure-boot-snakeoil.yml
>=20
> ```
>=20
> -For user-generated keys, create a new option file. This option file cou=
ld
> look like this:
> +For user-generated keys, create a new option file in the repository. Th=
is
> option file could look like this:
> ```
> header:
> version: 10
> includes:
> - - opt/ebg-swu.yml
> - - opt/ebg-secure-boot-initramfs.yml
> + - kas/opt/ebg-swu.yml
> + - kas/opt/ebg-secure-boot-base.yml
>=20
> local_conf_header:
> secure-boot: |
> IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-secrets"
> IMAGER_INSTALL +=3D "ebg-secure-boot-secrets"
> - user-keys:
> + user-keys: |
> SB_CERTDB =3D "democertdb"
> SB_VERIFY_CERT =3D "demo.crt"
> SB_KEY_NAME =3D "demo"
> ```
>=20
> -Replace `demo` with the name of the user-generated certificates.
> +Replace `demo` with the name of the user-generated certificates. The
> user-generated certificates
> +need to stored in the folder
> `recipes-devtools/ebg-secure-boot-secrets/files`.
> +
> +Build the image with user-generated keys by executing the command:
> +
> +```
> +kas-container build
> kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:<path to the ne=
w
> option>.yml
> +```
>=20
> ### Start the image

Where are you taking care of my below point? I don't see it yet

>=20
> Keys and certs generated by scripts/generate_secure_boot_keys.sh are not
> available to build command, so I have to move them in
> recipes-devtools/ebg-secure-boot-secrets/files/ folder to make it work

>=20
>=20
> --
> 2.20.1

--3P4pK14WpdMWOhEfQG8s
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 30, 2021 at 06:19 AM, Quirin Gylstorff wrote:<br />
<blockquote>From: Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<br=
 /><br />- Add code block for key insertion for better visibility<br />- Co=
rrect the template for user-generated keys<br />- Add information where to =
store the keys<br /><br />Add build command for user generated keys<br /><b=
r />Signed-off-by: Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<br=
 />---<br /><br />Changes in V2:<br />- remove unnecessary new-lines<br /><=
br />doc/README.secureboot.md | 20 +++++++++++++++-----<br />1 file changed=
, 15 insertions(+), 5 deletions(-)<br /><br />diff --git a/doc/README.secur=
eboot.md b/doc/README.secureboot.md<br />index 84131bb..0996edc 100644<br /=
>--- a/doc/README.secureboot.md<br />+++ b/doc/README.secureboot.md<br />@@=
 -119,6 +119,7 @@ to the current directory. OVMF_VARS_4M.fd contains no key=
s can be instrumented f<br />scripts/start-efishell.sh secureboot-tools<br =
/>```<br />4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the fo=
llowing steps:</blockquote>
<blockquote>+```</blockquote>
Do you want to mention&nbsp;qemu-system-x86_64 --version should be 5.2.0 o=
r higher as default Debian buster has older version of qemu and this step f=
ails with older version.<br />Also these steps can't be executed remotely a=
s it launches UI window for QEMU, so it should be done locally.<br />
<blockquote>-&gt; "Edit Keys"<br />-&gt; "The Allowed Signatures Database =
(db)"<br />-&gt; "Add New Key"<br />@@ -132,35 +133,44 @@ scripts/start-efi=
shell.sh secureboot-tools<br />-&gt; "Replace Key(s)"<br />-&gt; Change/Con=
firm device<br />-&gt; Select "PK.auth" file<br />+```<br />5. quit QEMU<br=
 /><br />### Build image<br /><br />Build the image with a signed efibootgu=
ard and unified kernel image<br />with the snakeoil keys by executing:<br /=
>+<br />```<br />kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:k=
as/opt/ebg-swu.yml:kas/opt/ebg-secure-boot-snakeoil.yml<br />```<br /><br /=
>-For user-generated keys, create a new option file. This option file could=
 look like this:<br />+For user-generated keys, create a new option file in=
 the repository. This option file could look like this:<br />```<br />heade=
r:<br />version: 10<br />includes:<br />- - opt/ebg-swu.yml<br />- - opt/eb=
g-secure-boot-initramfs.yml<br />+ - kas/opt/ebg-swu.yml<br />+ - kas/opt/e=
bg-secure-boot-base.yml<br /><br />local_conf_header:<br />secure-boot: |<b=
r />IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-secrets"<br />IMAGER_INSTALL +=
=3D "ebg-secure-boot-secrets"<br />- user-keys:<br />+ user-keys: |<br />S=
B_CERTDB =3D "democertdb"<br />SB_VERIFY_CERT =3D "demo.crt"<br />SB_KEY_NA=
ME =3D "demo"<br />```<br /><br />-Replace `demo` with the name of the user=
-generated certificates.<br />+Replace `demo` with the name of the user-gen=
erated certificates. The user-generated certificates<br />+need to stored i=
n the folder `recipes-devtools/ebg-secure-boot-secrets/files`.<br />+<br />=
+Build the image with user-generated keys by executing the command:<br />+<=
br />+```<br />+kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:ka=
s/opt/ebg-swu.yml:&lt;path to the new option&gt;.yml<br />+```<br /><br />#=
## Start the image</blockquote>
Where are you taking care of my below point? I don't see it yet<br />
<blockquote>Keys and certs generated by scripts/generate_secure_boot_keys.=
sh are not available to build command, so I have to move them in recipes-de=
vtools/ebg-secure-boot-secrets/files/ folder to make it work</blockquote>
<blockquote><br />-- <br />2.20.1</blockquote>

--3P4pK14WpdMWOhEfQG8s--

--tfUVqiMwbxspXsu6cqjj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6409): https://lists.cip-project.org/g/cip-dev/message=
/6409
Mute This Topic: https://lists.cip-project.org/mt/82480976/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--tfUVqiMwbxspXsu6cqjj--
