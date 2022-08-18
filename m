Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E818C25B08
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 02:54:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.37519.1660791250784250137
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 19:54:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 27I2s13H026546;
 Thu, 18 Aug 2022 11:54:02 +0900
X-Iguazu-Qid: 34tMJNUJFfVQbZv9XT
X-Iguazu-QSIG: v=2; s=0; t=1660791241; q=34tMJNUJFfVQbZv9XT;
 m=33F1XNVrHo4edONuDoXnGDaMV5o5ZL+gfCDe4PaXRMw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 27I2s0dR034251
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Aug 2022 11:54:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3Pq4H3okZB012+Lp7a4Osn0M5CMESUE96bUqNTWd2hGdHCdRBzlkd68QtRPQZBxPzYSvzTLPn7L1ryVjJ60ajcMeqFTb0TlxtP0zfGByjAQPUdObHHmY0zcXl/p+1JtgSkU83WEi+PzFirIGRPl/7JqIAA/wEr7LFEa1z7USfz0x7/HVrpJ0Xqrd+XgoMpPGRDiuiFVtXffy+DWRcTWwQF+r+MH3GzdGOzlD5UKgskls4h3Gr7/kvtT7JH+Z+gag1Y4ltpQpqQVB1Iry3wpt8brDt3zjrmKt/Og46IDPzRx14DavQJ+RM3Hd63hVZL+Nis8SjQaCfZeoc75C2EVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvOtq5HkeVx3NNzOPVsWGLlFwCKPjBwjX/ySagJVah4=;
 b=Ns+e8mkH5q9vIXt0yiNnAzidgJXJ+BBMuW0ntOK5dBTzyzBaZk9jB2bA2HDSg1YMHlK76/MfZs3jPKdYXpHMA7FHDxcGTFe6oyhqkBDZn/I/Jc6qKB8EJVjmnIMgZa0whOkunT7i57H0zMTWSa4xNY4WWhqK2op8CwPpzISwOM7FeRgC6mcy65Ow0gvPSR0Pqh8pHPXT3Gl1RtBc9UXg+BCeEqWZHcRhwkipA45ohK5JHDTXrHYcgri86LhgObRllH6jkyCHBLCo88jqynaMOFkkNyFDy2X4CO8W3LhdxpvrgPB4DI3Yvqwf+DVE1DUiNw/vHJTNJ6HJNmOjdASK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>,
        <Chris.Paterson2@renesas.com>
CC: <tho1.nguyendat@toshiba.co.jp>
Subject: RE: [cip-dev] Root filesystem for risc-v board
Thread-Topic: [cip-dev] Root filesystem for risc-v board
Thread-Index: AQHYriStNfx8pBBSWkm9PaS5DlRMra2z+jRg
Date: Thu, 18 Aug 2022 02:53:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB10136CC0682C1A71CB272A7ACE16D9@OS3PR01MB10136.jpnprd01.prod.outlook.com>
References: <20220812082204.GA16699@duo.ucw.cz>
In-Reply-To: <20220812082204.GA16699@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b281bf16-9a0a-457c-4630-08da80c4e5f5
x-ms-traffictypediagnostic: TYYPR01MB6860:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HiyRkfbreFfm21Sf/SZ1f0vWVa2ifeg9l9/Qy6d0dFhqK9CCGMTRGf0AsmXVV2GGDtIzvDdeqDdX2U/2GM6KHaQKYjQd4Ze/AGwy942L9Oo+tZ0NEw4xoT39Z7jQwlSMdXYKOUHVHmIRw3KwyLqQizF/NmgdT0FgSnYwWdjiLU1Zt40/R8TsHeju88uloM+yt9dUqg/BC++HL/R2m5MyTUKwS4LpLV4w7LqM7LWd9mwBoo6BXc7Iclxm9yKErBNgOIpbAfiKPcCRhv3L3WnvqF8o5QB0jrEmqn2fIeo9GbWJxaDl3LgsX42cREz09KCtPkWwGDqsC1e5OC3dorGrFlego0cWM76odcK132mB7DAFqdUJ3Gv5bkssIYLHZSJ3QJNGdl+OXVTqjOxQB229KPZ+ChMGN2BRvQ6vVlX/VvbnKoBinwjAy22CXNuMndl8UgAIqSGZq9TKnCsR9kHppHgz1uEwJScW2cweNdog7/+XW2KgFs4ecvRM38QRdfvQnHQo+Ya5ZuCa7LcWH2SVS4qbw04h8YXNZEzx1/UXv4YHPk0jW7809jGJ0ZQVD9mSQJusl9IBjeezToJh7xTd0V5dOIIsH6CtlqymPNxZ8KFHgafqX7QtcQIISfyuO/OUfy7bSTgHNCZlSH3sfYX2n5c3Ap3qO9WeG/oQi+EV+Me5RCUKrUe7amSvEoaq+E0M0y7iQzJIKsDExsiSwaZKEgbJRDz9i/DHDNLR7VhaL6vY1rk2Y1a2MDLNVTdRAi0qS6zTjYpqKfQAAkvqaa2G03qu4UYwpAybMSRSmrIv+bXLwZk2wbCpzGcrknlosM06DZEKjrbKiHHFFSnEqmxj/A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10136.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(83380400001)(52536014)(5660300002)(38070700005)(38100700002)(186003)(122000001)(478600001)(41300700001)(71200400001)(7696005)(53546011)(9686003)(66946007)(966005)(86362001)(107886003)(26005)(316002)(110136005)(6506007)(76116006)(66476007)(55016003)(8936002)(8676002)(66446008)(66556008)(4326008)(2906002)(64756008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RDIyZlJ4STd5bzZqcHpoTkVvQ3l5dUl5c2owUmJrdzRyMFhrKytLTXFL?=
 =?iso-2022-jp?B?S04yZXh3dXRnL0Z0UTlwQk5vZFhNK3lyZXBCdjkvdUI5SytaYzNyQTAx?=
 =?iso-2022-jp?B?cUJqWDExb1RJWHhRSHhFSG5Fd2ZzNE1wNnBSTTZwRGtvY05VMnZ2ZHZP?=
 =?iso-2022-jp?B?R3VDaVlJZWtrakJaZFoxVVkzelVETGgxTFlQNk5NRnA2d05FRW95a05E?=
 =?iso-2022-jp?B?WGUwQTZ3SFV2eXYybnV3ZUhpK1VVMkRaeUJ2eTBQZUY3TDNXR0dZTGRL?=
 =?iso-2022-jp?B?QXl6ZmVkWnN1T1FHc0RIRFN0LzY4d05vQzN6U0lXVUVCRE5TUVhuSmg5?=
 =?iso-2022-jp?B?dzdBejZXbDduTXc4bmJOaEFaaHFBUVBwY3VKVGtPcmppMm01Yy9JeWZL?=
 =?iso-2022-jp?B?bzQ2eTRwMi9uQ0ZHRG82RWk0UURRK0hsU3I2NVU5Q0ladkNSNEFUNFhi?=
 =?iso-2022-jp?B?eGdsVUx4akNHTmdkOURHREJGWlRKVmFYM2FZTmsrUnFHTlhSZTRpSEJm?=
 =?iso-2022-jp?B?aFhLKzZodGQvNkpFd0tJQVZERVBmNlpuV1dhSi9HekQzZERmL04yaDdv?=
 =?iso-2022-jp?B?T3R3cnZVbUdGSDVHVG40Tmk2Y01vTjJtV3c5dUxaQ05iTzlWYUlZeWhP?=
 =?iso-2022-jp?B?eFlSSjlNL2hYb2lmQ05kQUFDM2laekphbllxT016a1pTbnhGTFJLN0tu?=
 =?iso-2022-jp?B?dCtzOWRnM0xyYm9FckNCU0x3d0R1WjhOWWdNaEt4Y1YxZUZJa0xlTnB0?=
 =?iso-2022-jp?B?bThGc0RWSklWbGF6UmhiRklzby9FMTd2VG1POEJZRVgrVnkzUFM4enpL?=
 =?iso-2022-jp?B?bHVFUjkyYVJwb045UWx1cWIvSHl0VFVtOUYvTFlOSUZ3NE1GWHhydDdK?=
 =?iso-2022-jp?B?aDFYdG1SQml2bldYSC9JQ2FSV0JRSzk0enc5cWJtNE1FMlpJSXJuaEdU?=
 =?iso-2022-jp?B?Q2E4YStURGxBMWg4bzVESHA4TURTcnN3L3BTd3lBRm4rSFhndDNpdmpq?=
 =?iso-2022-jp?B?cjZNemkrMzJBbTJvUkpFZVBwTXV3V1VXc2ZHUXJIdXFUaFlYKzhFYnJR?=
 =?iso-2022-jp?B?MlhnbVp0Rk9oQkVwbFp1Vy9YdGZRWDhIOFl2ZDkvTE9RNmNTWTl4THRX?=
 =?iso-2022-jp?B?T0QxNjV3bXBuZk9jU0ZBZ1VtS1FJOExyNjJiUnFNZjdEdG9NUDBvZ1Ey?=
 =?iso-2022-jp?B?NGNXZXkrb2FXK1AxVE84TUVTeCtENTVONU1DNm1mc3BkL3RGbzdId2pE?=
 =?iso-2022-jp?B?R0JsTUZETFVCV1dEazhMRllkL2NLZ29GZUlMYVpha3hhWnlDZ0ZCUS9F?=
 =?iso-2022-jp?B?ODJtcXZlQStXbXNJb3IvVGRya3o1MUFwWGdMSERkS1ZIT0hFdTZ0N3JL?=
 =?iso-2022-jp?B?QTBqazNTRnRzNC9ldTRBbzBGRXVzWGRVYlFBU2dEUnNxVlJYTVZRd0N0?=
 =?iso-2022-jp?B?K1hQNXVtckM1dStnL2N5S2ZOVERtbTFjUXg3TFE4R2VibTY4Z05IWm5R?=
 =?iso-2022-jp?B?MXkzZjU3dktRd0JENS9vSnNhVE1wbUttZGdIWWpxRzdXeEt0ZERickYx?=
 =?iso-2022-jp?B?cUFDMFJlV2s2T2lCaW10SzdmNnloSElrVFJ4aUxqdmVyejFpUmRlbS9o?=
 =?iso-2022-jp?B?VEpQVjhlaTJkMWk1SGN6d2hJbGhEWUF4Z1hHNEZiUWFleDZBUVExeVJl?=
 =?iso-2022-jp?B?cVVvb3VIYjhMUU93V2dOdmtOczRVNTYvNzRQcEhPaUtnV0k4ZjcwdFV1?=
 =?iso-2022-jp?B?SXJmV044UVJqZzJIRTdNMXgzQkJ0TTVxdUQzU0xCOGNTSlhvcDhDT0tP?=
 =?iso-2022-jp?B?azNyV1BadHlLSWFYNll3RUJqQ3hkWXNGMTBjYWpKVVlVME1UVUdxQlRS?=
 =?iso-2022-jp?B?UlYybThlK01ReHB4VUJ3TGVlb0JFdld4NzJhRUJxUFp6RWZCRno1YU9h?=
 =?iso-2022-jp?B?OVpXMXlpcXI5OGVQcmU4RFFpeEphNGMxa1lCdTVDdHNBeGZZem85Sitp?=
 =?iso-2022-jp?B?NG1NSzNHZmtEbzNlTGx6MWYrZmNVWFdraEJKZWhnR2tWa20vTHozZW9q?=
 =?iso-2022-jp?B?R2pCd2RldUtrcTJhZURTMUFwVkUzYXdLczNMYVllQm00LzZNZlpOQ3Q2?=
 =?iso-2022-jp?B?UGFDQ3hPbVpsTSt2QWVERktXMVlxZHd4WGl3MTVUQW1YN0hJQWFMMTY0?=
 =?iso-2022-jp?B?b3YzRTNNdmNUZGVTaEpISlZ0ZmRtM1prUk4yb1pMUjFvT0FhK0lBNXFs?=
 =?iso-2022-jp?B?bTJNSWhaQ054NUttMGdqT1lpQmJPVVoraVQxaWRLOGg4ekFHYXFvNVBH?=
 =?iso-2022-jp?B?cXNxQzdSaWRyRm0zOW5sWTVYYnpsM3dKUmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10136.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b281bf16-9a0a-457c-4630-08da80c4e5f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 02:53:58.6192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 1UHTJrSqc2Ek8nqBC+s5OHM28gHRlIGT+aA3HDuiwPoK3IpzDvYE2q2x2MzX2s6dhufV4KStXlkNNmM8OLmK1cRI+6alX+Nw1hCep0PNmhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6860
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Aug 2022 02:54:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9283

Hello Pavel,

We have a development branch in isar-cip-core, by which
we can generate a rootfs for QEMU riscv64.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/thond/riscv-de=
v

Please note that this is not an official recipes of isar-cip-core and
there is no plan to be merged into master because it uses sid-ports reposit=
ory.

Step to build rootfs (tarball):

$ git clone -b thond/riscv-dev https://gitlab.com/cip-project/cip-core/isar=
-cip-core
$ cd isar-cip-core
$ wget https://raw.githubusercontent.com/siemens/kas/3.0.2/kas-container
$ chmod a+x kas-container
$ ./kas-container build kas-cip.yml:kas/board/qemu-riscv64.yml:kas/opt/sid-=
ports.yml:kas/opt/debian-kernel.yml

then you can see the rootfs tarball at:
build/tmp/deploy/images/qemu-riscv64/cip-core-image-cip-core-sid-ports-qemu=
-riscv64.tar.gz

By the latest CI, the rootfs image (tarball) was uploaded to S3:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/2702654409#L15=
86

Please let me know if you need more information.

Best regards,
Kazu

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek
> Sent: Friday, August 12, 2022 5:22 PM
> To: cip-dev@lists.cip-project.org; Chris.Paterson2@renesas.com
> Subject: [cip-dev] Root filesystem for risc-v board
>=20
> Hi!
>=20
> So... how do you get root filesystem for RISC-V board? Ideally I'd
> like to get something Debian based.
>=20
> Best I could try is debootstrap for Debian testing:
>=20
> sudo debootstrap --no-check-gpg --foreign --arch=3Driscv64 --keyring
> /usr/share/keyrings/debian-ports-archive-keyring.gpg
> --include=3Ddebian-ports-archive-keyring unstable /some/suitable/dir
> http://deb.debian.org/debian-ports
>=20
> Unfortunately, I can't get debootstrap --second-stage to work (I get
> sigsegv in ldconfig, I guess testing may be too experimental?). Is it
> possible to debootstrap stable or testing distributions?
>=20
> I don't think CIP project provides binary images somewhere. What is
> recommended way to get a root filesystem? Is there suitable
> documentation I should follow?
>=20
> Thanks and best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


