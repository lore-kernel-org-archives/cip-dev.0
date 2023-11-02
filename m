Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC1EC4167B
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 12:33:57 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.75])
 by mx.groups.io with SMTP id smtpd.web11.25478.1698909609780678309
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Nov 2023 00:20:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xD3VhRlz;
 spf=pass (domain: siemens.com, ip: 40.107.105.75, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6vUkCBH/yHEseJPYTeBZk56/vCY8kKR3B2hGmlrT/5k6qQwcp2Vcjfohxwpkr1TlTsysDzD+GiYlYT000//UQG8SYf+mV9v2LZgIAyf/eeAR0La2U763OJirVchRDqj84FDh4GVYbMQV6IjS/T0SqAAIvcbX7+TzoTJrFt1pIrd1+6wVh5Gl4o7XQLqtAzwibqcVerGrHEARRQ84QdEro1roF2K4dr8/e16AiNkkxNMhdTlBam6dak7c1ls4QnG3NWu0Z2oN2NWAEeHmm2tD609L7B2rVpLUkWLzaTfP6cnYUgcJ+LE0stXiYa3+he2A2iFkiYaScIDljU/eIeGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u1b3HgDA7F7EhlBysw3egFZE9kxGEONTcG8O77/aNY=;
 b=D1ldSrl6iU5ggHIgjplbVP/0Ku61M7qAV4yWzCX+sJnGm44nnkwjI2zIriXEqS/KgYtuAzJegiQNJBkF61G8rypIPVrAg36B8O42M+YZRgiaMn182BxLxvKBu2WZ3qQh8fkGgqeSSmq//f9ChbGeSIYQVvQv5FxFYzW6CWsm9GWkA2C0ZOLu5fYdqwlIO9P/kfa0D1TbC8XnmUN26golN7xPQWz8jvGSgStFZqBTaeUeaDLUT6bO5qdnm+fTbbqhULLJH/UqG3sqReU6zB8VYYj0FKHXBXc2LvjFQby2w26fzwuVkmcJIs8dVPXK+wjkggnAqfhBmdkY7f4hj9yoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u1b3HgDA7F7EhlBysw3egFZE9kxGEONTcG8O77/aNY=;
 b=xD3VhRlzH6xQtR1++WALjm57m4OX9mD3/Z0OMgQJkfWOmS11RTyiZeSUMJDRZJ2EdM6kJfSgKa9VUDFhtMouyefOQthC/rxykmae93jAmZAWTBXB4iq4xpRybtCxppQNq6VdGNvS9oyzdrv1Cwk1iSo259MGTilN2GKXnH5bxrk/C/BA5ztSXQbbLOehBjPv2HDjAFLtQZgy9e4Q46Vf59+R84eHE1xKF3U/+uh2lxFXvMFD+RWOtkHHwtWzTadjx9JNwvCdLX9HrzBGpdunhPx+PlB0pLSMOrUAfnYAgIpBAiXXcESfen0s0vd1EYmHPelXAa0CSYDkzrgV+zlQZg==
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17)
 by VI1PR10MB8183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 07:20:06 +0000
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::634a:5ecc:7023:f9c8]) by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::634a:5ecc:7023:f9c8%6]) with mapi id 15.20.6933.029; Thu, 2 Nov 2023
 07:20:05 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Topic: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Index: AdoM5xnui5+ATTT0SDWBKqFXTIkKDgAbCr2AAABS9HAAAXvggAAAiG3Q
Date: Thu, 2 Nov 2023 07:20:05 +0000
Message-ID: 
 <DU0PR10MB68989DC93C19FAE033CCA63BF0A6A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
 <DU0PR10MB6898C5AF36094F948A282906F0A6A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <49c7b36d-373d-4000-aef6-e867820b26e9@siemens.com>
In-Reply-To: <49c7b36d-373d-4000-aef6-e867820b26e9@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=2b6794d4-c6d1-4819-9f05-d9d362edad3b;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-11-02T07:17:26Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6898:EE_|VI1PR10MB8183:EE_
x-ms-office365-filtering-correlation-id: cae3bb20-6d4b-4fa8-2c26-08dbdb7422e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TmQVL0DXU31NryMvsU7S0sNO4Oav/QEp5/TTbz2+vyPZ+KAxge7IDXuTX0GEG2ZW/EDz67SgROqXk/dgjt0uAxnjW5vR2Ha5xJFJNwjgIIGpK+Sq5GH0czRemgoRa4af2dwWANzU5/LROE5nSvftZJSZLPoOmL6+dT2alP/9LsrXSqRAJMhjfL+/kq8M7pKxc1thL4qo/n3VaFpKCr1q9AmjCDVxIDt2wPF3PTXTGfHoVZxQVOIfGD7/FOU2+F1kpNIxz142lahIuPNAMTie6ppRsCDzbC78K+yXT+wlMzNJykPbSKV5YbEbjYwY3ERZTo1CfVFN+X4a5set5SydlBQ2L1KTB0BJyqf53nwUloPrq8xnnWVZOwU9uikBvFChviXhZb0TtQ6WXHUBlMMPO8fiGqjg0ae1TeC1yYCy+qjCbzCGfpJMrml8b3pYnwgGjqn30ddyfpiy3lAYJa7EnhP+0Hf07W6TewQbgwehXqysbB8GcovFdANyDbp07nyrM8V/PdBqzL4Ed7i1qv7ZsNnduuLG3+9GsQKmX+q4QEJeip6jMbX1J2mu1htpkX03MHvR4Gl229L1KDXPYR6qdnSc3gad8WyYe4g3A6QGmOM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(122000001)(86362001)(8676002)(8936002)(82960400001)(52536014)(33656002)(38100700002)(41300700001)(110136005)(76116006)(64756008)(66556008)(316002)(6636002)(66946007)(66446008)(66476007)(83380400001)(5660300002)(66574015)(38070700009)(2906002)(966005)(478600001)(55016003)(45080400002)(6506007)(7696005)(53546011)(55236004)(71200400001)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-9?Q?/CmiE99qbm5RtW/y4xTRpe3JHqraYeAIkph/CJoiOOgPT/w3vTfoA7LNgh?=
 =?iso-8859-9?Q?Vi7IkUD9lonnTjNH5iuher3ZDwT/m8BjipvTBeAyTPH4L3bx6y0Rsbdq+Y?=
 =?iso-8859-9?Q?U/BlQ/W1obcuUN5VJmtSQZ8Ar714NCy8EqOVmdJuuexxh1CIiSrP5Cmdr4?=
 =?iso-8859-9?Q?iBzjnsnlcUXmBGV7AArRd8Fx+nca+HdxQ1lXeyWKrC1dE/CyPSOekHCMle?=
 =?iso-8859-9?Q?E+ZqIt4LVNTG1/n+wx9wwT6OGXz1cIk0yb+9+fBeJucJz2iftyXz6qRxyX?=
 =?iso-8859-9?Q?fZKYZNeeEctX5OHRbRx8rf8JuPGq1HNesKLZkkc8zHouyvvhRoEA5BF60q?=
 =?iso-8859-9?Q?fEn5KFO7OHY0VsLBLhaVNvFKyd5F8rHfgyZ94s1oWVjg24NZXS3z0l7YVJ?=
 =?iso-8859-9?Q?Jg5BPh5YgMn47wxcXfyvCmnAolGMVg/G8hdvF507o8xMTDr6i3mcDAt7Xy?=
 =?iso-8859-9?Q?V4lBkcsKAZn4ntKsoaajAzzTYp3HgxVmeHjVYZQkHx+1dylmHKKgXDZcmq?=
 =?iso-8859-9?Q?yFAuM97pTDKC5m7rLude+frDfx83L4vQSvIGI3KoDPX7okZV4zw2meNfaa?=
 =?iso-8859-9?Q?yMQVHpI7SSyTQjVo1zYr8QkN2SwFatt8CtDn7a7Ny5KHxuCztYWsc+gzXG?=
 =?iso-8859-9?Q?iDrxNSO92t0EC0D1i0D/exTrERuDg+7isIvk6i/7NLhCDIjGnaaxPToIhr?=
 =?iso-8859-9?Q?7/gsoB4VITDqPkyN8reZm4Ymmpc1KiBoC4jEcdznvjTnWOTErTweT48eCu?=
 =?iso-8859-9?Q?rZaXpSFbWeXkshhJ8L15TOjtqPzUDqTWcv8+cddDtiTTzvJ7fI9iLvvwK0?=
 =?iso-8859-9?Q?JCevIbVW0ZZSxFkc/tzX1FJI5d4Q5Irirnv+KR9Zoxkk57Kr2720k9HLCW?=
 =?iso-8859-9?Q?8u/SestOIQAqe2jr6joSXMXGYx4mrMoIknWYDmL0KqZX3tDS8Jvj3sFani?=
 =?iso-8859-9?Q?YFctDYyfpeIAFJP0ShrBbdgiqkAHkU9rKPFjSiN2/pyTcJVrMvMS2QSswa?=
 =?iso-8859-9?Q?sQEWe+8hkLQQBGgSc//nCBEvR7vAvUuG5S+lMDihVyxCKsfxkH0Cbf19Wt?=
 =?iso-8859-9?Q?JFRFVQX4KiENe2vVP8dQbGTcypFK3DkAWu7Lg8G7i2qsSMtgPzepNHPNPq?=
 =?iso-8859-9?Q?hetv9MONUSl0siLYOE7MCy3Msj25uT57krR0jDrIpla8pmsRY47iPPCtUT?=
 =?iso-8859-9?Q?m1MxoXJFPBYr2M6gopyL9qfPgRdHCuZvNQbmbSGfB6hzKMHzmzPzg5VIz3?=
 =?iso-8859-9?Q?7Z4sY1+R1OLR6xrOtj7ZDLFt6T7xS7n9phJ0VKbp8Af7YILWAYn3S7jhJ6?=
 =?iso-8859-9?Q?FcI132zA224tOP+Rcoh2qu2Iz+8liUv8dTCNqF+6Dyy7NDsr9oxJiVMfRq?=
 =?iso-8859-9?Q?ctiXtBzH+N5wLCyIvNrHR4U0OXGMbrtlc81rk92BmCJmtM037zOzc3PWGY?=
 =?iso-8859-9?Q?9LQFLJ4FsJkUyTxEp2mx1N3Vbaz70H0GWL3i4CsAyr2PQTJ34wcJLa6iRm?=
 =?iso-8859-9?Q?9zTftpDbCeNOCIcxYvKKLU4G19qOXA2pBm9odGNeO17T+TxHkLv8rpA4gu?=
 =?iso-8859-9?Q?DMnbYR8XCI9Kti+09RhfcJRhwr4EDR/yRhg6t5+2TP0J5+PWXFJK3U55dq?=
 =?iso-8859-9?Q?uAzzaGzs46r9yXCaYcq9cicoeKJ5LexD+w?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cae3bb20-6d4b-4fa8-2c26-08dbdb7422e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 07:20:05.1339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+6agEhMbAN54Hll+GEz72xlzwJWVzoSrqkPPkGI3mu8148a97BqM/L8k+eHu/JNRVUc5bp1JuKKrM/UUaMreQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8183
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 12:33:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13516

It is definitely more vulnerable than sha256, sha256 is kinda default one. =
Afaik, TPM 2.0 brings the sha256 and sha384 over sha1 which is not a good o=
ption today.

-----Original Message-----
From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
Sent: 2 Kas=FDm 2023 Per=FEembe 10:02
To: Sari, Sercan (ADV D EU TR C&E) <sari.sercan@siemens.com>; cip-dev@lists=
.cip-project.org; Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemen=
s.com>
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis

On 02.11.23 07:45, Sari, Sercan (ADV D EU TR C&E) wrote:
> Yes, it is definitely open to a discussion, sha1, or sha384 may also be a=
pplicable.
>

Is SHA1 still an option today, from security perspective?

Jan

> Please take a look at the 4.7 section: https://trustedcomputinggroup.org/=
wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p0=
4_r0p37_pub-1.pdf
>
> -----Original Message-----
> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
> Sent: 2 Kas=FDm 2023 Per=FEembe 09:10
> To: Sari, Sercan (ADV D EU TR C&E) <sari.sercan@siemens.com>; cip-dev@lis=
ts.cip-project.org; Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siem=
ens.com>
> Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
>
> On 01.11.23 18:17, Sari, Sercan (ADV D EU TR C&E) wrote:
>>
>> clevis will fail to encrypt data when the TPM has multiple banks, such a=
s SHA1 and SHA256, adding the pcr_bank information resolves this issue.
>>
>> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>> ---
>>  .../initramfs-crypt-hook/files/encrypt_partition.clevis.script  | 2
>> +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevi
>> s.script
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevi
>> s.script
>> index 899f20e..957a3fd 100644
>> ---
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevi
>> s.script
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.c
>> +++ levis.script
>> @@ -61,7 +61,7 @@ open_tpm2_partition() {
>>
>>  enroll_tpm2_token() {
>>      if [ -x /usr/bin/clevis ]; then
>> -             clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
>> +            clevis luks bind -d "$1" tpm2 '{"pcr_bank":"sha256", "pcr_i=
ds":"7"}' < "$2"
>>      else
>>              panic "clevis not available cannot enroll tpm2 key!"
>>      fi
>
> Is sha265 the only reasonable setting here? Just asking as we are hard-co=
ding.
>
> Quirin, any remarks?
>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>

--
Siemens AG, Technology
Linux Expert Center


