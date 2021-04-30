Return-Path: <SRS0=0f/e=J3=lists.cip-project.org=bounce+64572+6412+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660EEC433B4
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 14:55:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D88613F8
	for <cip-dev@archiver.kernel.org>; Fri, 30 Apr 2021 14:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D88613F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6412+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YTpSYY4521723xUp4KFs7pGw; Fri, 30 Apr 2021 07:55:39 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web08.12801.1619794538180206059
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Apr 2021 07:55:38 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 13UEtaAs012315
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Apr 2021 16:55:36 +0200
X-Received: from [167.87.0.247] ([167.87.0.247])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 13UEpwOR001976;
	Fri, 30 Apr 2021 16:51:58 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] README.secureboot: Corrections
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        dinesh.kumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20210430121957.13306-1-Quirin.Gylstorff@siemens.com>
 <20210430131519.23750-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <087801e8-03b9-5333-1dfa-66b977285bca@siemens.com>
Date: Fri, 30 Apr 2021 16:51:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210430131519.23750-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gTfxGXVHGEXqUATvjk7nSTE1x4520388AA=
Content-Type: multipart/mixed; boundary="dfhMUxURwcnYz3kAHemB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619794539;
 bh=ScXDWV7Vtx+PY73SuHdV1kVz8Adn3tcefbE6idTyNs8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=r7QgvUP36b0Ly2+zIyEdwSa4HbQpXsF2Rf9jmgRtYS69u9nSEmKNDl2XdwxdgU7AEi1
 1q8bviQVlkVJ6suiwmaySVFJ3v/Wg/zfgLZxSh8SdVON80HIZnB0nhP5wjhTYX+2JsLoG
 3LPjqVii8FkaFvW+YQQQHusDQkIWq6VQ59g=

--dfhMUxURwcnYz3kAHemB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 30.04.21 15:15, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> - Add code block for key insertion for better visibility
> - Correct the template for user-generated keys
> - Add information where to store the keys
> 
> Add build command for user generated keys
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes in V2:
>  - remove unnecessary new-lines
> 
>  doc/README.secureboot.md | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 84131bb..0996edc 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -119,6 +119,7 @@ to the current directory. OVMF_VARS_4M.fd contains no keys can be instrumented f
>  scripts/start-efishell.sh secureboot-tools
>  ```
>  4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the following steps:
> +```
>            -> "Edit Keys"
>               -> "The Allowed Signatures Database (db)"
>                  -> "Add New Key"
> @@ -132,35 +133,44 @@ scripts/start-efishell.sh secureboot-tools
>                  -> "Replace Key(s)"
>                  -> Change/Confirm device
>                  -> Select "PK.auth" file
> +```
>  5. quit QEMU
>  
>  ### Build image
>  
>  Build the image with a signed efibootguard and unified kernel image
>  with the snakeoil keys by executing:
> +
>  ```
>  kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/ebg-secure-boot-snakeoil.yml
>  ```
>  
> -For user-generated keys, create a new option file. This option file could look like this:
> +For user-generated keys, create a new option file in the repository. This option file could look like this:
>  ```
>  header:
>    version: 10
>    includes:
> -   - opt/ebg-swu.yml
> -   - opt/ebg-secure-boot-initramfs.yml
> +   - kas/opt/ebg-swu.yml
> +   - kas/opt/ebg-secure-boot-base.yml
>  
>  local_conf_header:
>    secure-boot: |
>      IMAGER_BUILD_DEPS += "ebg-secure-boot-secrets"
>      IMAGER_INSTALL += "ebg-secure-boot-secrets"
> -  user-keys:
> +  user-keys: |
>      SB_CERTDB = "democertdb"
>      SB_VERIFY_CERT = "demo.crt"
>      SB_KEY_NAME = "demo"
>  ```
>  
> -Replace `demo` with the name of the user-generated certificates.
> +Replace `demo` with the name of the user-generated certificates. The user-generated certificates
> +need to stored in the folder `recipes-devtools/ebg-secure-boot-secrets/files`.
> +
> +Build the image with user-generated keys by executing the command:
> +
> +```
> +kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:<path to the new option>.yml
> +```
>  
>  ### Start the image
>  
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--dfhMUxURwcnYz3kAHemB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6412): https://lists.cip-project.org/g/cip-dev/message=
/6412
Mute This Topic: https://lists.cip-project.org/mt/82480976/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--dfhMUxURwcnYz3kAHemB--
