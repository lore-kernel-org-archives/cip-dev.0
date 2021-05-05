Return-Path: <SRS0=10o8=KA=lists.cip-project.org=bounce+64572+6431+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B161EC43603
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 18:54:55 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4B461168
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 18:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4B461168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6431+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kz7LYY4521723xJRw8wUNG90; Wed, 05 May 2021 11:54:54 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.1292.1620240893464204291
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 May 2021 11:54:54 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 145IsoDC009632
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 May 2021 20:54:50 +0200
X-Received: from [167.87.16.18] ([167.87.16.18])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 145IlXui024614;
	Wed, 5 May 2021 20:47:33 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2] README.secureboot: Corrections
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
        Dinesh Kumar <dinesh.kumar@toshiba-tsip.com>
References: <20210430131519.23750-1-Quirin.Gylstorff@siemens.com>
 <18306.1619791584153988370@lists.cip-project.org>
 <9c3ef309-f2e8-0624-a118-d3e375d40559@siemens.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <77651949-83ac-5a97-4ccb-b047d9f21867@siemens.com>
Date: Wed, 5 May 2021 20:47:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <9c3ef309-f2e8-0624-a118-d3e375d40559@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by lizzard.sbs.de id 145IsoDC009632
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: X6svUWDUIc045snzA0cCHUgUx4520388AA=
Content-Type: multipart/mixed; boundary="gUv5fdmYcbWQmOCqQQYw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620240894;
 bh=LslefKuEKxDaXg+pLdwtyzOfuaZdO1INAopZJ+BNvqk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=H07h/yd5xjiqsUHLa8WkhyBL6i1l9OCQ13eEZNE4K8MyLeAMpkGiexBb/aIx86ql/pJ
 2JqcpOKHU+jrTKhYcbqzvLpDA+9jNZ1rL1Fvg/DZO2QeNMZOsF7RXWc9hsjfO8JvrziAS
 8co3oTZgv3TLK3kyVN5dkLbRYpXAqC+4NlQ=

--gUv5fdmYcbWQmOCqQQYw
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 5/5/21 6:47 PM, Jan Kiszka wrote:
> Dinesh, your citation settings are broken. When sending plaintext, as i=
t
> is common on public lists, you need to set the mark "> " at the
> beginning of all cited line.
>=20
> On 30.04.21 16:06, Dinesh Kumar wrote:
>> On Fri, Apr 30, 2021 at 06:19 AM, Quirin Gylstorff wrote:
>>
>>      From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>>      - Add code block for key insertion for better visibility
>>      - Correct the template for user-generated keys
>>      - Add information where to store the keys
>>
>>      Add build command for user generated keys
>>
>>      Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>      ---
>>
>>      Changes in V2:
>>      - remove unnecessary new-lines
>>
>>      doc/README.secureboot.md | 20 +++++++++++++++-----
>>      1 file changed, 15 insertions(+), 5 deletions(-)
>>
>>      diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
>>      index 84131bb..0996edc 100644
>>      --- a/doc/README.secureboot.md
>>      +++ b/doc/README.secureboot.md
>>      @@ -119,6 +119,7 @@ to the current directory. OVMF_VARS_4M.fd
>>      contains no keys can be instrumented f
>>      scripts/start-efishell.sh secureboot-tools
>>      ```
>>      4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the
>>      following steps:
>>
>>      +```
>>
>> Do you want to mention=C2=A0qemu-system-x86_64 --version should be 5.2=
.0 or
>> higher as default Debian buster has older version of qemu and this ste=
p
>> fails with older version.
>> Also these steps can't be executed remotely as it launches UI window f=
or
>> QEMU, so it should be done locally.
>=20
> Feel free to send a patch (or MR if that is easier) that adjust things,
> Dinesh.
>=20
>>
>>      -> "Edit Keys"
>>      -> "The Allowed Signatures Database (db)"
>>      -> "Add New Key"
>>      @@ -132,35 +133,44 @@ scripts/start-efishell.sh secureboot-tools
>>      -> "Replace Key(s)"
>>      -> Change/Confirm device
>>      -> Select "PK.auth" file
>>      +```
>>      5. quit QEMU
>>
>>      ### Build image
>>
>>      Build the image with a signed efibootguard and unified kernel ima=
ge
>>      with the snakeoil keys by executing:
>>      +
>>      ```
>>      kas-container build
>>      kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/=
ebg-secure-boot-snakeoil.yml
>>      ```
>>
>>      -For user-generated keys, create a new option file. This option f=
ile
>>      could look like this:
>>      +For user-generated keys, create a new option file in the
>>      repository. This option file could look like this:
>>      ```
>>      header:
>>      version: 10
>>      includes:
>>      - - opt/ebg-swu.yml
>>      - - opt/ebg-secure-boot-initramfs.yml
>>      + - kas/opt/ebg-swu.yml
>>      + - kas/opt/ebg-secure-boot-base.yml
>>
>>      local_conf_header:
>>      secure-boot: |
>>      IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-secrets"
>>      IMAGER_INSTALL +=3D "ebg-secure-boot-secrets"
>>      - user-keys:
>>      + user-keys: |
>>      SB_CERTDB =3D "democertdb"
>>      SB_VERIFY_CERT =3D "demo.crt"
>>      SB_KEY_NAME =3D "demo"
>>      ```
>>
>>      -Replace `demo` with the name of the user-generated certificates.
>>      +Replace `demo` with the name of the user-generated certificates.

I added the following sentence to the README for the keys:

The formating is off:
>>      The user-generated certificates
>>      +need to stored in the folder
>>      `recipes-devtools/ebg-secure-boot-secrets/files`.


Dinesh is that sufficient?


Quirin
>>      +
>>      +Build the image with user-generated keys by executing the comman=
d:
>>      +
>>      +```
>>      +kas-container build
>>      kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:<path to
>>      the new option>.yml
>>      +```
>>
>>      ### Start the image
>>
>> Where are you taking care of my below point? I don't see it yet
>>
>>      Keys and certs generated by scripts/generate_secure_boot_keys.sh =
are
>>      not available to build command, so I have to move them in
>>      recipes-devtools/ebg-secure-boot-secrets/files/ folder to make it=
 work
>>
>=20
> Quirin?
>=20
> Jan
>=20

--gUv5fdmYcbWQmOCqQQYw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6431): https://lists.cip-project.org/g/cip-dev/message=
/6431
Mute This Topic: https://lists.cip-project.org/mt/82480976/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gUv5fdmYcbWQmOCqQQYw--
