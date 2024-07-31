Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AE6C52D54
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 18:02:30 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by mx.groups.io with SMTP id smtpd.web11.48158.1722445293026832242
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jul 2024 10:01:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=jan.kiszka@web.de header.s=s29768273 header.b=svXayVNd;
 spf=pass (domain: web.de, ip: 212.227.15.3, mailfrom: jan.kiszka@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722445291; x=1723050091; i=jan.kiszka@web.de;
	bh=oWYFIHanqUUpw6zIayAN7+2kiNsoqYPPBm88URIgsII=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=svXayVNd6HxT8wLUn+tw0aVwx+6ssI9fVyFeJ49VuILCJEYFdmQe0wa4UA5EsMHS
	 smbLeEOubQfgGwPRdlxAML4Yn6J+zhzcxNB1byBeRtp77EIb3zWi4Umrea8bKnVpS
	 EvcwaSRCtGhJUbhPy1sAXqO/zGj/Qzl0EdgZI6YPj7smWH2LYf+uYBMRWHZDeymDm
	 sbZp7LjsT8jnoGxHytBzkapYThDtde8q/bPFSIDnH88B1O/OSnRGCnzACBHu2UBnH
	 55oANGDDGZ6DVD6EiUVwBKD6ovfwj+TfUHrP+fqDuV9znsIa/PVMzU7JzWn49NRmF
	 0s3g9+voMY+AH3OdHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.168.54]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UkQ-1sAV2e3IFe-012lZj; Wed, 31
 Jul 2024 19:01:30 +0200
Message-ID: <a3127393-00df-431c-baa1-2d9354d12367@web.de>
Date: Wed, 31 Jul 2024 19:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] IEC_template.yml: Update revision of cip-security-tests
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240723175117.2471090-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <20240723175117.2471090-1-Sai.Sathujoda@toshiba-tsip.com>
X-Provags-ID: V03:K1:qnxG6zwEuLh7v6HRSkbVdYWx4QKElH5CyjN487NFJEcXny1t729
 /CrdTLygdXlbgpc1KaormcuRovE2vxPYylMJ5B1eCzdbqzmElEhp7JLJa+A3giWMCc1ZEVX
 TDtmRhxMohspxEhsDRszoVXvU9y65IV5gPaol3NdH1MZeIwCrTF4g/+q1xYC/TBRE9/IHtC
 Gz+dnLycSAbECs57+7oIg==
UI-OutboundReport: notjunk:1;M01:P0:/WQkKfnCU2A=;gUki24ii8vaA2pVQ1ASUMEMnuYO
 TMU+7hG8tboTy/EizvW+b5MkAlz+EI6Mt4FfY6m8tU17GE6gFC14QChz/2u7tYCppuISgsuLC
 705FRyegyFO22x7NBtEEkObdoJse/6n9EEECqkpUHow/py4Z4gcpNbabvKk357Yi+lGN1KjdA
 OtgTZb/TApClhgeeeL3TnZnUtOrJrSGULR39agaubnU6ngGwjGjk7c7SyVWlAFI5SJsHV67gY
 g/El1Fi1lwL6xgxiuHxHCtnF2ADRIzUsf9BNlpgdzTZjB8hjvpjEZ2IF4V6OmHxQZHWzUCXIe
 Z+G3UbcJW7tzxuM1xd/oNen+k/uUycrKf5hV0MExbRLIyOCS9gEa8Xg3nZ1UNba/OE/89WaAl
 qpisNbnmw9SfbxRSMC1avp7f9Zjd4+MJ2IKjWFB6MKs4BMztrOARGE3wlnPzgiozEBkiY4v7d
 Avza27blBSxaRiWzaFzuwMSm3MEBJk4jwFvNEDfK0xbqmaSwlG4jKwqmWSBlJSgJHK4ZcWPd6
 VkSTQKQu1Tls86ul+ZDe72/5mQS86pT3ucHTgE8yKUVeubs9OjFaHMMa9180GPaIZBBudiKWa
 aL1ql56qnrFk88H2H4pbcOq9qy79XFCqEePzlqP5D/rZkOSmzhs+YsxymHChiBvEP5+todBHR
 /0ZAxDMkV/bpcgXD7Mwm/5WydpslgpyiwawHcE1K25QIKhcJ5fgSZxEqW90ZFR1ddVrM1VwrX
 X5oj1oG2jRhz+Vms7QUkQMSOxcWxdgxFo6Sqs92PTTg2P+ZTn32KgfzAzDyco7m3ZGrOF1VF2
 CbjZy/o2h98aE3WJ9HYyTeFA==
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jul 2024 18:02:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16696

On 23.07.24 19:51, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>
> It is expected for all the test cases to pass with the revision
> mentioned in this commit.
>
> Below mentioned test cases are fixed with the updated revision.
>
> a) TC_CR1.11_2
> b) TC_CR2.10_1
> c) TC_CR2.9-RE1_1
> d) TC_CR2.9_2
> e) TC_CR3.4-RE2_1,
> f) TC_CR6.2_1
> g) TC_CR7.1_1
>
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  tests/templates/IEC_template.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_temp=
late.yml
> index 1d46791..a196bb5 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -64,7 +64,7 @@ actions:
>       definitions:
>       - repository: https://gitlab.com/cip-project/cip-testing/cip-secur=
ity-tests.git
>         from: git
> -       revision: 07021c3b7455ed354a00f4de0f1a7267788c414a
> +       revision: 064a92b98127b0001ca527a83b175521bea4b626
>         path: iec-security-tests/Singlenode-TestDefinition.yaml
>         name: Security-Testcases
>

Thanks, applied.

Jan


