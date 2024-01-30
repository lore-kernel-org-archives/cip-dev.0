Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7506EC46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 05:34:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.12021.1706592889081606680
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jan 2024 21:34:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 40U5YbUx4155768; Tue, 30 Jan 2024 14:34:37 +0900
X-Iguazu-Qid: 2rWhr2isDyqFqaVNjx
X-Iguazu-QSIG: v=2; s=0; t=1706592877; q=2rWhr2isDyqFqaVNjx; m=noaNiH1Q6gcGNa0gwWTWESHNnVWLw94hcVBU5IiMRcw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 40U5YaQt1247427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 30 Jan 2024 14:34:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvJR+iqmXjkFkdFUJ4/kJ0WTG7PeGWfjcKB3hPsV+hmCIkqqz6u8DcP7IirD75D8YH7AdU/ZGRAMFD1YKO3eLFgq5XSFORp94KeilpRNqpLZ4gXOGz2Nx4jRHZa4y0f76sElFL4Ei9kV2MJhZp4M9LDd60eMQC+1iyZYOdUtFDVK/dcXAJdCKGGU/8pkeGdZ0vfeCLEmK/qrBpKAhsghP4hfWbBIxG1z/SBldOjBW70U0W+edgw7nZ5O+/RPSUs5BXZPKZYBd5iuckkJ/UaLPzNIcEAwxa6awFHO2GSTnWpuSnteXfTV1d4xqDDgBuHUbHNoLQVyEW9bkY4yVoEPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzSRrx/Ps5ybDNbD6r1Nc8bWeK3XKVH/GKUKOC1Lta0=;
 b=lycVHoYAwklCO1pQIhm5MlURuPd42pOLG/QRb7f08gCsrlCzSZdrRRfHl1qjdgOtZSm1MGXzka76UwZlEiiPmhS8aODsEG79CxvenBMrYaF+xb5d/LrYo9NAOKFvA8EoMskryCFmMfNK0+nXxClvKxcJPZvwDteXZ5gVk9hbWs7FkRexpprlMHq/ytg0aZ1jecY8Hw+Fb3+nWQ9OVSuFjqHYtXS5PxPeD7Wh3FFN7hR1/tBr4zYB+qDF4Ahjd/FjMCSG6J8EzVlG+hOizRT5tQAOmRUOJM1DoPIhSdiHsTginHQnGV1/xq6SL1kIwTk88TcMQyis405SelDJ/Iy1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/2] Add IRQ affinity support for IRQC
Thread-Topic: [PATCH 6.1.y-cip 0/2] Add IRQ affinity support for IRQC
Thread-Index: AQHaUuf4ak/DCoHBCE2K9FRJEqoYa7Dx0hpA
Date: Tue, 30 Jan 2024 05:34:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388181EE39FC04C88103D58927D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240129191829.45687-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240129191829.45687-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB6296:EE_
x-ms-office365-filtering-correlation-id: faa77244-8ad3-4eb5-53a1-08dc21552453
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 H0YfzKm3Y+5iYfsew+qonB23GqPI+1zShc3WAqwXRFwiNg1mWFI6h3x40wSHReVZCp3YdexIcooKNVvfG0n3iacP/pih+3LoAsK7OVmGjgOtIPVsJPUjDMcAcGLAogEDkAkxgi5uYdRIRHut6AsRTU/weTsn8/4okU5RBdaFq84dX6AjOffcnydx38bjFCwjgscCi4ixqj0dUMhX1ey8EyBPE3U8U2smCKzjdamaX9lV8bEDsb8JHxf0YAIcavjXYcjj2yk9jR0ssx8yMPkok0udFSRdeSXHKVwMH5Ko3Kl2bMDVwUGYMZj81y0WVlnpLZG9ZTe2aExivnp71k/CtRus62BuvMXwls/A0Odr5aROLFWUOuGA3Y0ONAvjVSQDv4YSNN90TjiA9EcbILruIEPrluATjrF3NOWgSAmTT1Qi3a/eiGnDmCvy7ukNfLbFW1begTNHBT2kUaDHA/UOR+B3/RxKIsLMXuUMxl/Alwk5Lnti9X+GTYTjvispPv3+agTtCIUVVPY9L/mvyfL5qeRJb1ev43KZptq0KhvQT7Ehk3NoK5gtKjYtEZmxRaVqe7TGHb+Bpqqdmp0orHpDTs8iQuCTZx9G6jekWKlGgtgHaJFKMyG9Gc5GeC5PGU1GU05WkDnqfat9Kv9fzYKuNw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(9686003)(53546011)(26005)(7696005)(478600001)(71200400001)(83380400001)(6506007)(52536014)(966005)(8936002)(4744005)(8676002)(4326008)(5660300002)(33656002)(2906002)(316002)(66446008)(86362001)(64756008)(66946007)(110136005)(66476007)(66556008)(55016003)(76116006)(122000001)(38100700002)(38070700009)(41300700001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?STNLV2gxcXlwTWkwMEVSNWRvUFpHSDgvbXltRVNGRkM2ZEJvVW5WMDRs?=
 =?iso-2022-jp?B?S1ZmcWZnNG5zN21oZ0g2d1hJZ3IrMGcvRDJYS0JUdHRGcFdoOFNEYVN5?=
 =?iso-2022-jp?B?andmbDBibUgza0VaQktUMDg1U3FPV3pSMmp2TU1vYzZSdDdEWEJNa2xC?=
 =?iso-2022-jp?B?a291QXRWaFowanJMNWtCM1ZWS01ycTVqSi9NY1lLNFBveERzSUdINVhI?=
 =?iso-2022-jp?B?bFhjNXhuQWIvSTFFZUplb3ZvVUpHSzA2UU4vVVg3RXZYK2pxNVd2SjdC?=
 =?iso-2022-jp?B?SlRhL0xVVGs0c2diTVQwajRpZDFSN29GejVrUXRUdVNCNzAvLzErRlBM?=
 =?iso-2022-jp?B?UzNqOGJndXpUUzlIRWQ4UVlXNkkvVTc0NjFJc0ZGL1hRMkUwdGk3MUR2?=
 =?iso-2022-jp?B?NjJtdStIMXpLLzV6cUhDdmhweFB5SEY1Nkhrd3RMMjdKWlI1VlRQbm1K?=
 =?iso-2022-jp?B?RDBHYW5zbjBOcE9yN1BVNnREK1BXajcrNGtlWHhGeEp5VkJSQjVUSENu?=
 =?iso-2022-jp?B?SjM4ZU1HRWlZaXVuMkZkRy9BWjNCUE1zSVRMeEhYSXhKWnZEeDFCNTJ5?=
 =?iso-2022-jp?B?bzBpWUlsR2lIcmF6WXdkc0sxUFZaK0JhdkNkRnkwem9MaW8zNUVkSXNT?=
 =?iso-2022-jp?B?dlg4TWJHYkxFeTJKcWp3NFczSjl1N25OZU5zaUdmZjJSSjNtRWlkclY4?=
 =?iso-2022-jp?B?TmFiRFNHQ1hwTTQreEM0NE5DODkzd1N0UXhuWG1IT1JTYlkvb0lGQ2hZ?=
 =?iso-2022-jp?B?bGtZc1g5RVpRTXQ5ZWdEdzZRdmtzYUNnYTRrcVNYRGg1aGxDNlpUWFUz?=
 =?iso-2022-jp?B?NFNsMDlSZ3JJMk9SU1pJV3RQRlhTN2lyS2YzL296eWo2TVRkS29maVFN?=
 =?iso-2022-jp?B?Z0huUW41WnU0VExHN3EwajQyRE1FcEFaVGxqNjFvbUpQZFJ0RENHT1JV?=
 =?iso-2022-jp?B?UGU0UEpFMm9VamlvS04zU2pvcTROaHcyS1A1V1Y4SGdHRE1NU0pBakdv?=
 =?iso-2022-jp?B?WllhVC9SUDBSekJlNHh6a3JscUNHTkxncG1xb2o3aXZyVlpMak1kbzRa?=
 =?iso-2022-jp?B?WDZWNkwrZWVHb2kxbEFReVFDR1haSUNxd0xpcjVZdzhTVXJITTU2VWFQ?=
 =?iso-2022-jp?B?TXhiTzBIbWFlMnRsY0Jpa1hpVUZQZ3Zqb0dEZFUrbDlRVm1HOGFJUWlH?=
 =?iso-2022-jp?B?VlRTSFNuQm9rSk5Zd21TN3phSUN3a3ZzRW5QOStLc1FHeHdXUFZ0aEIz?=
 =?iso-2022-jp?B?Znc1WW9xTGRZbW4vU3lEQkxIeFdtMGl4ZHJQNkFWSjZYSHQ1SE9BZVMy?=
 =?iso-2022-jp?B?STZMbVNZTGd5T3J2Vm1YWXlKc044c3A3bVRLZTl1RVlUNHpRcmRRUnJU?=
 =?iso-2022-jp?B?eFF1Z0ZJM3Z6MHlzL3hKUHBobzVGc3h2N1RDOHJTVTBXSUdWVDFIV0lN?=
 =?iso-2022-jp?B?dGhkZHF0OVVOcmkwczB4dzZmTGQza0JoUkhmVGwzYTdUNkRWZ2VaSXlP?=
 =?iso-2022-jp?B?MjZQU3l1SDg2MnR0Vm85WWxob3JxU3d6Q2U0eXR5YnZvVDduWnhHQmZS?=
 =?iso-2022-jp?B?YXlLOGhQVGVUaHArVlNWRjZRY3ZaQk8vbjRoYld4bkpYRFlBT1lIVUFK?=
 =?iso-2022-jp?B?REZ3NENVWUg4K1IrbDlvenhHbjA1OGREakdGV2hPK3pkWE5mYysxeXhW?=
 =?iso-2022-jp?B?cmFYaE1WaHNic1Nma1NUZFpZSWFwRThPRkM4TGU4ejFSdmQrSERjVEtu?=
 =?iso-2022-jp?B?WXo2V1dBVUpuVjlBdnFjcXZpSHNpbTY1L09ONmJSRGVRb3h3VFBUelpF?=
 =?iso-2022-jp?B?Sm56ZXhSRkJaZllkdFZlTjFLcXNOUm5YTksxZUVUWloya3dkUWpGcHNx?=
 =?iso-2022-jp?B?VU5PUFVXd3E5TFl3Y1BBaVZlVzhGcVIvT0pXRmd4T2dGajA0TWtMOUVq?=
 =?iso-2022-jp?B?anAxWnBLZFFkOHJ2ZFRzcGRkTHRFMGRPdjNickxvMUJHWVEzK0dDZzBx?=
 =?iso-2022-jp?B?S3paemkzMmJCYnQwQ05YZWcveWFFRURtSUNkTURYcTQ0RWN5allLSjBo?=
 =?iso-2022-jp?B?aHk4eCtxeTdDS0FHWTVuUGJ2SjdEQWdUaFVVRmxHdWF5U2t0WU5ROWJG?=
 =?iso-2022-jp?B?OUk0WEZHY211TlpreCs4eXlQbDdNMGxEMm9EZkQ2OFFtWGMzRXB5Q2RF?=
 =?iso-2022-jp?B?eVdNU1RLS3ZsaEI5VFdwSmRhVDlGeCtsQkVMRURSSE1JbjNqWGxtVENN?=
 =?iso-2022-jp?B?Rk50K1VSd3pYUUxkZ1Y3SER4cVU4cWdkZEgyRVJnTkI2ZGkrUHQ0YTlS?=
 =?iso-2022-jp?B?RDZTWU1YZG1yeGYxVkYzaVpBdGw5WkF1N3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa77244-8ad3-4eb5-53a1-08dc21552453
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 05:34:34.4584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SW7RgFhRIQmxGgu0AsKh3JF/3Tzd3ehw0/C1+vo65p5VvNIcyDy4P9ejDtCaXSqWU92lciswZUCXy+A2IhOJ56hd7usnOx2HDQaFrKhm9D5cl94MSbiDi5iX3+GvKFKn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6296
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 05:34:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14488

Hi,

I reviewed this series. LGTM.
I can apply this series, If we have no other opinion.
Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/11570=
00194

Best regards,
  Nobuhiro


> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Tuesday, January 30, 2024 4:18 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 0/2] Add IRQ affinity support for IRQC
>=20
> Hi,
>=20
> This patch series aims to add IRQ affinity support for IRQC driver.
> Both the patches have been cherr-picked from v6.8-rc2.
>=20
> Cheers,
> Prabhakar
>=20
> Lad Prabhakar (2):
>   irqchip/renesas-rzg2l: Enhance driver to support interrupt affinity
>     setting
>   pinctrl: renesas: rzg2l: Enhance driver to support interrupt affinity
>     setting
>=20
>  drivers/irqchip/irq-renesas-rzg2l.c     | 1 +
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> --
> 2.34.1


