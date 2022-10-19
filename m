Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23572C4332F
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 13:05:33 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web11.7463.1666184724867058429
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 06:05:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q5S4g83t;
 spf=pass (domain: siemens.com, ip: 40.107.22.86, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Todc/1ZcyGHlga5orbikReGQL7B3vqeBjK6UfsKdYfcWPZugVJM2oDFR4pZK64+CLbKh1eqoEBbKPrjF4s+D8I6J+YmoDszaNPkd1AvXKSLgoc6t68bAxnmWKSTxdcj/pxsOKxipFRoWyyDBx4EYzsEoZvsZ208tdfq0mvQiD9EQ6SMTslZ2J1JZEpJlbQJ0qM7+EReXCDAGsG9mOH6A3Oc/osLKSM91z33ZYv8R+2NkOjA/4KgEaErRGNa5yjVHuh/uIKyvlt5c+NyubKpAYXnMEaa+FW18zgnHxfcoOqWHjBIHg9CGiHPQgiL6wypoTeu4uedkE9UR5wzfSIw7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waAXyIIq2OQ6yVUwOn+kCqzshOqVt1R+6WZekknqyKI=;
 b=bPL3Sphh7RUaBcreYA7fz11LazxMKdFuMiaKzy24+2Awo2J7O3zo80R+mIcK3x6/aZxO1QDvs1xy2IBVqwLuZNXNsVygrd9kUdjAL2OsNYGJlv7WzNiVahIN4VqXoKKfMdjzJCWL83WsvXNBiNwGk9NTdx635gZgV8F7eJRGU6H/huB3lqoRaENq4086iBiLF286YNqzLyA5kR8AGRJexdxlKnJZ6rl3u3qOexflYcwtPzvYKiz3s4dtcn3ULOhtTJwYmvaHGvqiKs+rxbg/sdLYKiaGGCgGhu5KY7ij0U9te1un5CY+Nw1VIH3cwqY86X59zmpN+7uMtEiA++IKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waAXyIIq2OQ6yVUwOn+kCqzshOqVt1R+6WZekknqyKI=;
 b=Q5S4g83txzgnWg54psuVdTXHOsT3K5gAQdn2LGIKmifUBJobs4KdL8X/t30No9mpDVs4C0y4EicAm9uhW91wYEW1iBBdjNUCa4FgeYWtlsNSs15C21i0Se7LiOaEcZY0oFl3DnARFrgdnO09w81OoT0VjMtcPrPQgl5PSVxzgWURo3kRqxL7NfSgc8WsYDv+1bIv9SQh+JYjqN1xi6ar5TsYjafTl26Oe1SfhKwoFc6p2qUm/A49GAzZ9qdXnDmIAtodZtM6JqYzYOibgeIisxqNL+f9fbfqJut5Y95Y6RVVo8jNiHXCBjq8FrS4r1CYQdxwtL7ZhXWKq9Il5xHcEw==
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DB4PR10MB6216.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 13:05:21 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 13:05:21 +0000
From: "Schultschik, Sven" <sven.schultschik@siemens.com>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: AW: [isar-cip-core][PATCH 1/7] add recipe for optee qemu arm64
Thread-Topic: [isar-cip-core][PATCH 1/7] add recipe for optee qemu arm64
Thread-Index: AQHY45wsnIm0zVHIc0WuLwEY8hbfpa4ViD8AgAAkbqA=
Date: Wed, 19 Oct 2022 13:05:21 +0000
Message-ID: 
 <PAXPR10MB50378126C15801DC63D38C72902B9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
 <c020dd31-5cc6-4be8-bee1-f313e816a817@siemens.com>
In-Reply-To: <c020dd31-5cc6-4be8-bee1-f313e816a817@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-10-19T13:05:20Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=dd013075-7cab-4c70-bb1f-f497415ff68c;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5037:EE_|DB4PR10MB6216:EE_
x-ms-office365-filtering-correlation-id: 810a94c3-7cac-4201-e688-08dab1d29471
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 d6bDHxz2jczGTOz4fguSL1sMIC042/rstoRX/k/tr0mAa9QYaF390Upwq0zJbLBPEbt3QD8mq2fgYElZRsxliMFEBbs8XXmcmMoFrnE9VQwW2U3mmpe/5F1OMrPdtzqFrMtCQdOAo9mH2ockmWLyGBCvwQ9BVlY5tr7WV8+s3rOf7UwHd2t3d+yQ5mw4fS4H/ZHIdkllOYpbflyRXrj+aN7XB4Cylgn7kM0apuHEZlnJSZGeJTT3WwRZkPeupPXyH/i0mtglXNIrdfbbkZQzwpceHsSIRwDY9jboleSTEUgpwbz8ub84c28W65Gs3C01mKfUXSmUlBii+/XwNfNU9m7VZ28iXxIQblQGuSTdTg7a4+kXM8Ig9F9S3FFLEpIOqVObAGIEIBekWfCSCny8NHC7rXebxy48h8m2z7y/2c6sgBNfotxLQxQQDHazdgkf6GzX6diD80/UDEUDpbQ9X9w8Lf76djYmcvrzSZIoBLROE8FmuElLfwda9mYgxrrhtZLdbeQwdCpnXGWjdZRW3VpbOj2/14uyywdCR2w5xGog9rJaITa4eNuf/37kMJFx3ziFHWc4rWiBpu33k6SvKNQbYMBjhh1tk/hTCr1/Bde6rYctVumxztPTivpcmPkSI5egBVdJRU1VBL4pxf4RNVRdUKnuy6hk43tUkXwO5SQ/wEutl0AgUTlAQpCQW6mhJCWdu7kKfeCXPL53upZK5Pm5pDlv0741VXwGBX4d2UZ6rslZ/O1GXww+LsQsr9dbxn1WqK2xr9qTUDJwYwiyAg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(86362001)(83380400001)(38100700002)(478600001)(186003)(7696005)(6506007)(110136005)(122000001)(9686003)(33656002)(38070700005)(316002)(71200400001)(82960400001)(55016003)(2906002)(5660300002)(64756008)(26005)(66476007)(76116006)(66556008)(8936002)(52536014)(8676002)(66946007)(41300700001)(66574015)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?MRU1s6EMB708/z4VryasehLdZ2HcOPh+9u76joSLJM1+XUIAmuWR0i66+Q?=
 =?iso-8859-1?Q?adQXhsMjhkvDIX0l5YXC9KAI+MGRzrCa2ntlkOcFVb4Q4nckmoqno1mq9V?=
 =?iso-8859-1?Q?3f1lqpRMBBc/yZ8Ne/fmldstw/oiOQQ6AU/T8Ewz5dAWnQkVvuG5J1WBQN?=
 =?iso-8859-1?Q?ay0MfmGrta1xZ+VU6fiwrx6BaCSTGQc/XlSZosuPhpxpqvd4nz3EzdUoaH?=
 =?iso-8859-1?Q?WFIgn72tP0i/tbGZOHBzXsGvDZnpGKS6/AeTfXKj32LCOMUXIT7MNnGaVR?=
 =?iso-8859-1?Q?iyeLIARQI68dT4t4xki7VHU5Z2/KoxnhWORakbpsuSZHDh6/ZpRZlLeFY1?=
 =?iso-8859-1?Q?ujZxfgKWYZkPfsu/aGpkYeGVmcho3UNKQX2pobAUh9AOl9puDcLP485AJ3?=
 =?iso-8859-1?Q?BdXrx4n16NtO5sW3jVubjOYYFugBmT/enXFO7WqW2e7ixv+/BkGsryAJZG?=
 =?iso-8859-1?Q?11kbYB8QhBtm7i/Dm53sI+3CehTtq0rbeSEskFGDi9/oC+JCzXnR0LV/yE?=
 =?iso-8859-1?Q?CP/vabclC8xnq/r43oJFlniEF9LSMqlBK5V4TuBypvL9pTPiMiAm8QPK8M?=
 =?iso-8859-1?Q?/O8lkTgk31BhP/JXDCAo0J8vrD27IRRZhByketRHoCz2sGYMeSsUepewD6?=
 =?iso-8859-1?Q?6xAZ0cyNx0tXZEDgS+7W3vBNJRt/9rGgwrEuFnKKbf2/AQADXpv3A3AtKF?=
 =?iso-8859-1?Q?tLZRdLtXvWQNm23o1VMFYD7u0mEM25ap9uMSavZGOGmHm9jQqvWOBEykGp?=
 =?iso-8859-1?Q?xbJuxew8b0unzj0Pm5A6DZDxHPEj94+FB1pQIzb7BT76+IMqC6swXFwhrs?=
 =?iso-8859-1?Q?JPNHqvZN5ZQsViIITNa6ZqFWsSeYKXDKjCrAln8mlekFHU2STKTQHnn4HV?=
 =?iso-8859-1?Q?WbPLnnd/VB28xE8Udtay/XpgtcEzAGXco0MuPMhdC9wNDYG76pCeoTXvi/?=
 =?iso-8859-1?Q?4IlHHU7Pj7BoUmHH4PY+0bgl08GjHumlu2jRk/cXSQ3h3nGx3eaixDd35F?=
 =?iso-8859-1?Q?H7TjB1jGk5eKE06wjvWjuKHfmUDx91TlDhjq6mbCJN1WbyYB5ke/2ZlfeE?=
 =?iso-8859-1?Q?L4B/sbVUdFCEgAS6aKo6CXZq1UCL6CO6c5275WVgf4jig9BMq222x+Mx+d?=
 =?iso-8859-1?Q?WvPXflrvV1x3Xxy2t63WtaO7o3AIhuO+MJV3t6cIqyWgSwj56RwaT1ZMPs?=
 =?iso-8859-1?Q?yh5VKFkDOJ5xXjGK5o/aeaZ9ZcOOw55iYb84D9umJn9dFKDQlc+zeTZvAD?=
 =?iso-8859-1?Q?wVTimQQwVVjItFPY6fMW9rRPzwdda9QMf1wK78c3RPJSrasQrRZ+E2djTZ?=
 =?iso-8859-1?Q?r5S8shfd+oEMbiKS5aacR7FJS3jVM58BTBpifFmFHzsiK+tNJrVXYU5mhC?=
 =?iso-8859-1?Q?Lz4RQEChujVsVWQTlVmvZtlOpygOLgtCVznM22vAXpfapiz0qo/V4VxVHL?=
 =?iso-8859-1?Q?clelaoXtyRTlejbJo4nkSXFA25qHXZed7EHxEr0DHyb3CIp44yowUfRA3Q?=
 =?iso-8859-1?Q?Fs5FlxrcRSUb5LR7qAKWZA5AnWwEER7PEzQWK1Vh/ibW16l0Q0hLO+g2Ea?=
 =?iso-8859-1?Q?thHlLKxCkx1rfhJpiq92ey3VJg8jiMbjr7498dV1MNehuzRkHE8a5rScSO?=
 =?iso-8859-1?Q?+P7yzYxY06Xbd1AucUmWVfpQAT3CdDGPumSf9flFI/3gYUfbpMuD3FvA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 810a94c3-7cac-4201-e688-08dab1d29471
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 13:05:21.7462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIZUu1fYEcu7jaqjd7fFU+18UJj4EE89RsgLmcDp4FgmzxrkBpzSwHbrGmuZmwqOt/2KCfeXOnOcrWN69lZLCh3UJBsmFe5YEzgt+7gliAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6216
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 13:05:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9785



> -----Urspr=FCngliche Nachricht-----
> Von: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
> Gesendet: Mittwoch, 19. Oktober 2022 12:44
> An: Schultschik, Sven (DI PA DCP R&D 2) <sven.schultschik@siemens.com>; c=
ip-
> dev@lists.cip-project.org
> Betreff: Re: [isar-cip-core][PATCH 1/7] add recipe for optee qemu arm64
>
> > +    gcc-arm-linux-gnueabihf,"
> > +
> > +OPTEE_EXTRA_BUILDARGS =3D
> "CFG_STMM_PATH=3D/usr/lib/edk2/BL32_AP_MM.fd CFG_RPMB_FS=3Dy \
> > +        CFG_RPMB_FS_DEV_ID=3D0 CFG_CORE_HEAP_SIZE=3D524288
> CFG_RPMB_WRITE_KEY=3D1 \
> > +        CFG_CORE_DYN_SHM=3Dy CFG_RPMB_TESTKEY=3Dy \
> > +        CFG_REE_FS=3Dn\
> > +        CFG_TEE_CORE_LOG_LEVEL=3D1 CFG_TEE_TA_LOG_LEVEL=3D1
> CFG_SCTLR_ALIGNMENT_CHECK=3Dn \
> > +        CFG_ARM64_core=3Dy CFG_CORE_ARM64_PA_BITS=3D48"
> > +
> > +ISAR_CROSS_COMPILE =3D "0"
>
> This looks wrong, specifically as you are installing a 32-bit cross-compi=
ler and
> calling a 64-bit one as well below.

Optee has it's own weired way to cross compile. If you configure optee for =
arm64 and activate ISAR cross compile it breaks.

Just come in my mind. I could delete the exports completly and set isar cro=
ss compile to true. So deactivate the
Cross compile of optee and use the isar one. I will test if this will work.

>
> > +
> > +dpkg_runbuild_prepend() {
> > +    # $(ARCH) is the CPU architecture to be built.
> > +    # Currently, the only supported value is arm for 32-bit or 64-bit =
Armv7-A or
> Armv8-A.
> > +    # Please note that contrary to the Linux kernel, $(ARCH) should no=
t be set
> to arm64 for 64-bit builds.
> > +    export ARCH=3D"arm"
> > +    export CROSS_COMPILE32=3Darm-linux-gnueabihf-
> > +    export CROSS_COMPILE64=3Daarch64-linux-gnu-
>
> That is a deprecated style, and sbuild will complain. Move into the rules=
 file.
>

Sven

