Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1329C4332F
	for <webhook@archiver.kernel.org>; Sat, 11 Nov 2023 23:50:37 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.85])
 by mx.groups.io with SMTP id smtpd.web11.52277.1699711624901172051
 for <cip-dev@lists.cip-project.org>;
 Sat, 11 Nov 2023 06:07:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OtmHAZXa;
 spf=pass (domain: siemens.com, ip: 40.107.8.85, mailfrom: sari.sercan@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ijelsp5Fi1Bb1yhQttUP7vysrFXryEcv4mH7+w9TXlAAeB+y/JCLhMwleg8Eh7ppjNxcmty5fhGSYgoyPJnvOeNNNeM478acm15Xj78jUiltyubHtW8GZS7ZNXAni6s+oRqE2S3UAsErRwGwk/EqPtoZEcPqQ0w1dMjqwYZoJpwu/VfdEe+G1yqWeE/GpIrxe4SLpo1EHmIVVjbI80foqMd9+YoKDgtwr6Ad2lzzOzqmjCwqlXa4IOkJfvQvruFNj6+9ehudHJDzrgUMzGvh8WOOy56iLC3SKdmSrZZekjV88A40+KZ2YZiRDvbFWL0BiR5/pdAITe/kSHjCMhBAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlBs/0H5nbKHNOusXXzzfgiDun70vjX6be0VkPA7gwg=;
 b=dTm6G8XFg04xzB9d+qH1pMZhsXBoSpI1hphaVVrUxUC/4Fj/0bRhNqoFNxgbP6VJkm+rFkf6/vceXPkFFfQOGZpebI121GKw2HnEk7NAh3qSY6hYH7tGeMY5kF/oW7hZloBzRiPqKuyHO7jR/1OrYk5MCa7gcXcsPnnk1tInlzyw6TWZ02Bdp5T9M9fO1z5jTnD587zOFwLXoepbCLtNxnlLZVlBlGXyCBNza7QRkCX/76pty2+qTtzXvQ0DFf318/EcX9+MHUTtOFR2/kyGt6aFgTrkLLgS0z+tWInH9IyRVOniEDi/W+qUOoRVKmawSLKUaKe5ESHLaQtSijzSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlBs/0H5nbKHNOusXXzzfgiDun70vjX6be0VkPA7gwg=;
 b=OtmHAZXazNG4dD7dOIgRg6F8da9IVbO7aOuDHWIywRn/nZm/FnCWDE2avdIM19Uzh70/7w9LcNsSj/vovp5RqyP4wmmVmuwf+EbsnqMBsbTokQziz21qViEEIXHWj7jpRpBtQxWSkC/o9S0r9F7D3x2QPCA2QEFzzn9LuW0VGnUWZXIYft/TwW3fyhOGHRRBMxjQTGoAL7ORa+53HTVvYrrWSkgQmpVDOK8jps8H1BueWLSEwZBhta+XoYc9Bg/kUXQyQZhww3UdlSDtMYCmHZnmrgEV6x1m0QXFWfWMRbwIMV7rU41qX47KrC8pyUBSR3ydIg9fnqxySX/Yo/UUIw==
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17)
 by DB8PR10MB3721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.22; Sat, 11 Nov
 2023 14:07:01 +0000
Received: from DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e23c:dfa0:3f1b:5c45]) by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e23c:dfa0:3f1b:5c45%4]) with mapi id 15.20.6977.019; Sat, 11 Nov 2023
 14:07:01 +0000
From: "Sari, Sercan" <sari.sercan@siemens.com>
To: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Topic: [isar-cip-core][PATCH] added pcr_bank for clevis
Thread-Index: 
 AdoM5xnui5+ATTT0SDWBKqFXTIkKDgAbCr2AAAQcUoABZuRjgAAAM3KQADQNxgAANf6RoA==
Date: Sat, 11 Nov 2023 14:07:01 +0000
Message-ID: 
 <DU0PR10MB6898427679A68F4E8999AF36F0ADA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
 <588aaf59-facb-49db-bbfe-2c70c9866452@siemens.com>
 <05341db4-c9a1-40a6-8b48-21d32ee53dec@siemens.com>
 <DU0PR10MB689816B42CDADA5720DC10D1F0AFA@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <872409ca-683f-4730-a7d9-a6727e267856@siemens.com>
In-Reply-To: <872409ca-683f-4730-a7d9-a6727e267856@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=f5e4c254-57e0-4b64-8752-1e7fd382bd0a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-11-11T14:06:33Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6898:EE_|DB8PR10MB3721:EE_
x-ms-office365-filtering-correlation-id: 31dc78c5-3134-4ff2-39b1-08dbe2bf79a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0gYxSvel/OdVCNWqjyTIhV8ocRc4iZMfqOcb9hw+4vhBdxolwGT6pwHZ0FjcDkpTFVXgRWy3zMkdjopUTbS/GONPvn82WbkD5taVilidpgmXxdBmdf56vQXx+IvX9Ta4zD7X+6sq2naCpYEz7O7P3Wy6shtFyfT5GO4u0QQq43HvF03ty9I7FQnJBEDB3ek+oJ7QOHfBWR2wx/N1kDHyNhXCuGtJnaM7scBJ1QEFwIljBe1ZovQKlE6ctoJRJFvDISEdIJ+v6NDs5A619h6j3uj0Yc79R0STSCAzMlyWslEad1JlRVPCE+P63zA5vdxo3rPYkgbOGIjd0/AbVZQHuVzw71Q31rgJWIrTfqvVODUiQlnGgX4GYGtgY/NChhFsNmG+S/w0J46GOMOA7bE/U7UJlw7hhN6w2V3utSuhOCRqziQmiFvGOXcIQGhMHHEZhN9nmvZPEwXoXyTHsDDPQSwlX4B6Zo9LRWQ0Me/s3kWNwKJXs1FLNxjlgJd0b5MJYjd8QQPLC1cVWJUN10h4u2yKyyoMAPgt8JgdnP0wMG8yCZSlrPM9ynqi4wp5fS5o5lXkC5i0vaCChCqID4niXysiN5zB56tiV/AU6cbxGX8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(26005)(38070700009)(122000001)(7696005)(6506007)(33656002)(478600001)(2906002)(966005)(53546011)(82960400001)(45080400002)(71200400001)(86362001)(9686003)(5660300002)(38100700002)(66574015)(52536014)(55016003)(83380400001)(8936002)(8676002)(4326008)(66946007)(316002)(66476007)(66446008)(66556008)(64756008)(6636002)(76116006)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-9?Q?+uLwUKo8AeGIxwHAAsUtp4+LWKoXSSnu5dAf3bgUUBDf/kUB4ct0SB23oD?=
 =?iso-8859-9?Q?R78cOzZZgz0fhVvr23lg4SGIhm26G6d1ZCT1aaGtUP+SdYG4Wd5wip496n?=
 =?iso-8859-9?Q?k100rwUgYm9VbfgQxHIzh9XKgQYQN4UAAvU5MWV0lw8mmNbyzAir0dG44E?=
 =?iso-8859-9?Q?OzV7dq8GUoYHuDtm1h+3QqLgWYBHV/6O+d3yY0xoFdZIEEHvGGJCIjjrUY?=
 =?iso-8859-9?Q?SICswpAl0L+1rsPczrYAb1s3Cy5iu9YqwLTwXeBcbN4jDzgMvHJWoL3ffr?=
 =?iso-8859-9?Q?o6QoVfGuaxKNMqEMcyo8gj5fbHsRO1xnAh5Gdyl4vtnfNLF37EklBY+NUo?=
 =?iso-8859-9?Q?QllJwBnNR6C0oXQ6FgOcYhpneXeAtCq9BhHrLRycXqZOmmma3tsldHNOpI?=
 =?iso-8859-9?Q?D1zo9jagnNhKKd7D0a/RAKm5bTVM71DHdZU8dSKTD1w9RzgWqZam++fFA1?=
 =?iso-8859-9?Q?O1MbberI7mh4BALnnyIbw95+ZoCmyabQB6t6GRlGLzIwiSFm9qEXGBMOZI?=
 =?iso-8859-9?Q?RIO5V+VrikqAMG6jwXMitSvjZPwhGXFCtslqpm4fJ2DdABVXfT6syrO6kS?=
 =?iso-8859-9?Q?z7XjKhwHOgEIy4NbFEO2Pxd7cTdFxNWdA7BeUzu0jGEMOCYsmZKWlxK5J2?=
 =?iso-8859-9?Q?sow03saHGpqLEpShWWEZ+G1l8M5Wg76SV7bzB9zpyvCBudNJXKahOnccCz?=
 =?iso-8859-9?Q?35340H6PHn9U11EbQJ7yGge4GNDA82xDSepvw7YVmg8dJLZ8FJGftQknei?=
 =?iso-8859-9?Q?NvCmh+MlkyGEc6yNxE0hwa0ZVDR7v4ag7ZU+fqKQ8a13x6GmIrdr4O0CBn?=
 =?iso-8859-9?Q?cW6qpqhr09iQGG91zajZTgQstdkpGGimD59cHsyMuFH87/6sfJwsrQPgga?=
 =?iso-8859-9?Q?iQVn80lJDdhuAM7GlEFGZih8gOA2ia7OGNX9oKizjFBlQl1gMBHqYEyx4n?=
 =?iso-8859-9?Q?YLJcO9NK3kiiYJ0tcRlx3wl3yWKPgl6z7+S2z9TgTXiNKk3qAYmhWp6BNv?=
 =?iso-8859-9?Q?furvqHv3KmirWE1+7no1fgyhHWcp44OE5Y8K0QPpGXmlD33C1VG+kyK0Jg?=
 =?iso-8859-9?Q?VMkBdn3qoU7i/DxrV/CDKFPZwj2QFUZOlyQPZm3X9yagXCwMWN/VboO3kv?=
 =?iso-8859-9?Q?qhqBQNvhnTiZhdVSO3TyWtNvZr5Vip43ynQ3AjaOoIippQFZ6wsQNWMCjo?=
 =?iso-8859-9?Q?XhR25TfNr23xWx2AWo8g6LR3F5LTUV9bHn3Eq6QY02OdGJ6hUd09frkDpv?=
 =?iso-8859-9?Q?1Ph6VzIpqSaVg9/+9BU0z5xNl8gmGqdVC9mcE5NS69JIQItQu8FdLcckgp?=
 =?iso-8859-9?Q?uQOV6EK/UywnSr3ISa9IENnEA5JPxF/lUelbs2Lc1HhJ6FDXTatfoJUDu+?=
 =?iso-8859-9?Q?tHyAqxiUk6ajpfmt2uh7qdVgxMm3l25VE3irS7eKJwmBDZg/SAqoIGjSvQ?=
 =?iso-8859-9?Q?LlvPqWBm6gNpiAhpnsZhL5QvHwJdXkfqGwnnnKQO+XfluMY3YGqbZW3shc?=
 =?iso-8859-9?Q?EMzvBhPLNyhlWg3o2rss1jHCTM/QgKfiAamHGbLsuRdO07zX/iEkI4LS7k?=
 =?iso-8859-9?Q?iBkFlC9W7BGH2VOZ3WM9nhMyiuVHOgrsA91Y5YJTcxI/d8HuqmOMLQp0BH?=
 =?iso-8859-9?Q?yvuounqhpcAczzGxc2BNLr2cnbxY+JdCxL?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 31dc78c5-3134-4ff2-39b1-08dbe2bf79a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2023 14:07:01.0347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jRamUdrbxMRW3FJwPTM74As3Z+cSlimduxIjV2arobXNga3PZ5EbDGfyUzVJGdGQm861KSdhEfwcT/ryNHtkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3721
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 11 Nov 2023 23:50:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13570

I see, I'll send the configurable version.

-----Original Message-----
From: Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemens.com>
Sent: 10 Kas=FDm 2023 Cuma 15:21
To: Sari, Sercan (ADV D EU TR C&E) <sari.sercan@siemens.com>; Kiszka, Jan (=
T CED) <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis

If I look at the official documentation of Microsoft. It looks like there i=
s a possiblity :-(.
```
Windows checks which PCR banks are active and supported by the BIOS.
Windows also checks if the measured boot log supports measurements for all =
active PCR banks. Windows will prefer the use of the SHA-256 bank for measu=
rements and will fall back to SHA1 PCR bank if one of the pre-conditions is=
n't met.
```


https://learn.microsoft.com/en/windows/security/hardware-security/tpm/switc=
h-pcr-banks-on-tpm-2-0-devices

Also there are the SHA384 banks.

Quirin

On 11/9/23 13:26, Sari, Sercan (ADV D EU TR C&E) wrote:
> Is there a possibility to have a TPM 2.0 with pcr_bank: sha256 unavailabl=
e? I don't understand the exact reason why it should be configurable?
>
> -----Original Message-----
> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
> Sent: 9 Kas=FDm 2023 Per=FEembe 14:24
> To: Sari, Sercan (ADV D EU TR C&E) <sari.sercan@siemens.com>
> Cc: Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemens.com>;
> cip-dev@lists.cip-project.org
> Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
>
> On 02.11.23 09:08, Gylstorff Quirin wrote:
>>
>>
>> On 11/2/23 07:10, Jan Kiszka wrote:
>>> On 01.11.23 18:17, Sari, Sercan (ADV D EU TR C&E) wrote:
>>>>
>>>> clevis will fail to encrypt data when the TPM has multiple banks,
>>>> such as SHA1 and SHA256, adding the pcr_bank information resolves
>>>> this issue.
>>>>
>>>> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>>>> ---
>>>>    .../initramfs-crypt-hook/files/encrypt_partition.clevis.script
>>>> |
>>>> 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git
>>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cl
>>>> e
>>>> vis.script
>>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cl
>>>> e
>>>> vis.script
>>>> index 899f20e..957a3fd 100644
>>>> ---
>>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cl
>>>> e
>>>> vis.script
>>>> +++
>>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cl
>>>> e vis.script @@ -61,7 +61,7 @@ open_tpm2_partition() {
>>>>      enroll_tpm2_token() {
>>>>        if [ -x /usr/bin/clevis ]; then
>>>> -         clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
>>>> +        clevis luks bind -d "$1" tpm2 '{"pcr_bank":"sha256",
>>>> "pcr_ids":"7"}' < "$2"
>>>>        else
>>>>            panic "clevis not available cannot enroll tpm2 key!"
>>>>        fi
>>>
>>> Is sha265 the only reasonable setting here? Just asking as we are
>>> hard-coding.
>>>
>>> Quirin, any remarks?
>>
>> I would make it configurable. clevice supports SHA1(default) and SHA256.
>> Quirin
>>
>
> Some follow-up already scheduled, Sercan?
>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>

