Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A77FC10F1A
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 08:55:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.5552.1715244901031538297
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 May 2024 01:55:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4498swUV1199444; Thu, 9 May 2024 17:54:58 +0900
X-Iguazu-Qid: 2rWhclmqRJMOQFPqDe
X-Iguazu-QSIG: v=2; s=0; t=1715244897; q=2rWhclmqRJMOQFPqDe; m=F1dwbVqe8djKps+XbK+U82Lrv6KnH/7+OlpmfIKtENg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 4498stKC3735970
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 17:54:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho5vV4XZkxETZu8/S1t97aiuUgfsUO+zHQk+L6e5yAPZwFRcx3TyG0yME6CGJgfD5l0k/Wn7UaCtPv/gYO1XVJaHmpsyIe2GoqGkxt5aoU8VivNlBOsKK61/r42nvJgOqzCd51VgJexUL5zSR2rhg/B+m82D+Zx15z4Z0EFQVKGI1LKWqjktLsDDTo9eeZpss+Szmxsuf6cZ9x0UkJE4GmL4DRc/4j1tfjXzZqO3Y73CTvo/kvggk/RwVDg+f63IWFyrjs8p/LY0hbMArcpMdmUjd1cSFg/uakc0sJOHX4E4hynlMMljj2J0FHpAlIPJfqg6QTXJStBC+vKt8qpQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvKIcGU6NTBa+l3SftBNlKc0z4sG3NdVhC8jP8NlUDU=;
 b=QPL4uzmlmQgZ1XOzhJ3OqzeZe6sIT2DuFiPAtIou7rFyOTsI7gkVqdmSdFPxPdqdeBVe4lXjdPJhhy1Ml/GQQcc0Q9aCtxYqARcq5VuxDOx5d8FD0xuy4RP1qeYBOwWtU1bxqiPTDStpQBsfkNluchCR/W/efnwBLOupPOwnbIldbkorpYQHl/tvTt99YVkdo8gzxMdfC2qPJE7FvI8nFEqLBN0zEsAyo79/VcNtqHDRwUfnHNngWLl0jYMQESKI5K780ztEQjFy5M1cDngLTOPrf1GwrCzQG3Y9b1LTNGGw3cyYhVLyDa5JQEyt/rEcpeIRwqvIwfbV6c5lIFhQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <Chris.Paterson2@renesas.com>, <schilling.benjamin@siemens.com>,
        <dinesh.kumar@toshiba-tsip.com>, <iwamatsu@nigauri.org>,
        <quirin.gylstorff@siemens.com>
Subject: RE: [cip-dev] Generic x86 kernel configration
Thread-Topic: [cip-dev] Generic x86 kernel configration
Thread-Index: AQHanXLNkTWoL+NQfkuQ7NPX0U0Z27GNhsKAgAAA6wCAAAN5AIABEteQ
Date: Thu, 9 May 2024 08:54:53 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075F2400D6FB592B37DE2A5C7E62@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <04b43c19-f26d-49c9-a12c-71cf3ba22e63@siemens.com>
 <TYWPR01MB1186261BB1B3D572F59B287E5B7E52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <078e13fd-59cc-4955-be45-9ad5906eaf29@siemens.com>
 <AM9PR10MB4085D362B7DC095E040E755F81E52@AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AM9PR10MB4085D362B7DC095E040E755F81E52@AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: quirin.gylstorff@siemens.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-05-08T16:14:04.7350782Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OS0PR01MB6354:EE_
x-ms-office365-filtering-correlation-id: ad54694c-a13c-4c1a-92fe-08dc7005b147
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Z1F4dU1pMkY3cDhtZFJlTVJjR1B6NTlQVG11aFhRNEo1WE9VRGl0c0Yv?=
 =?iso-2022-jp?B?dnpmK3d3S3o2OWJ1Z0ZJTEl5aGtzOWgyMUh2cG5JekJiVGJXVU5YN0VG?=
 =?iso-2022-jp?B?STREYXNOUC9sWS9CU09sSFpqUUFzYTVsR1ZwRFNUbS8vY1hyeVlaSWUz?=
 =?iso-2022-jp?B?QnJ5TkpJUGd5SFlNWXlRRkJKVGhPZEhJUGo3aDFQc3JvSVRYYlR5TEly?=
 =?iso-2022-jp?B?QmpDbGdMNHgwK0NiWmxNbjc2SElvbFNmVVd2eVV6cHBqK3ByaENGY1U2?=
 =?iso-2022-jp?B?eFU0cnRIMXFDUnlrR1crdVNPZmp4aG43QzVGNHBReUpkS0JiN2FMazhG?=
 =?iso-2022-jp?B?ZHk5Q08xN203MWpJVVpwb1hiRlFxeUhCRlZKT1JWRG50Wm43VXRHdkdp?=
 =?iso-2022-jp?B?THo2Z2tWcGdvQndxRUVRQW9uL3Boa05sODY2WVdlOGVsYTlKbTlpSHFV?=
 =?iso-2022-jp?B?bE9qay9aSjd5SjFlUFVSdDRyenI3OGQ1WW9ROFhKVWxyVlRCbVltalBh?=
 =?iso-2022-jp?B?VWllWVJKQnB3K0x4VEFrNThyckRIRkdld3NEeFFnS2xNNkJUeFFjYWl1?=
 =?iso-2022-jp?B?cm5kV3ZWbEFnZlY4VUEwT1BQVllyN0R4UnhzWXR3MjRhTGNHTTlUeTlE?=
 =?iso-2022-jp?B?TW41OWVBVmJpZnFQN0J2UStmbkwwZnd4VDJMcWwyUFh6bzJBWVllWHR0?=
 =?iso-2022-jp?B?T2tVRDdUVXcrNXZ0MHh0NlRuSm1aZVpuVkJkek1uYjQveEQzWm54SHIz?=
 =?iso-2022-jp?B?WndzQ000RXJlSk9nUnM2THFCS3A3QzhSM1FYcWJwVW9HS2RvaURUVUZO?=
 =?iso-2022-jp?B?eUUrZldGYjZFKzRPSXkwaUwzU2thcjg4K2hEWWdwQjRDRitOZ3FySU1z?=
 =?iso-2022-jp?B?c0FFQTBsUGxFU2VQd3ZadmFsaHAyUjllQ0EyZ3lWTEF5cFZIcE94SVAy?=
 =?iso-2022-jp?B?M3hsZjUxazhndktraGR6TTJTZUU5OWNaODdQS0lBZkhKcGRaWGo4MFcv?=
 =?iso-2022-jp?B?d0Jra3dxVG1Ndm1GVTFqbjE5VFhSL2d4VXN0Q1dDd1QySVdWcFVLNlhw?=
 =?iso-2022-jp?B?b2EwdEo1bC96aHNTMkxROURMVUd6S0xyOGRXamFNa2NHME95WmJZSmMw?=
 =?iso-2022-jp?B?aWRBNXNtcWt5SWpsc1pTWHB0amtPbzRsck5WaWdhMFFtcFRNc0R4a21M?=
 =?iso-2022-jp?B?cFFnVEVPVTJ4Q2VYYkN4MytRQlUrK28zRVFkTVcrdlJNOTg2RGhFc1I2?=
 =?iso-2022-jp?B?WEJaNXBZRWlHYzc1Zk5BSHRhWjE4M1p0RjNnUU5TbjJGcjEyb0h0enlI?=
 =?iso-2022-jp?B?bnR5MVNrZllYZFVxUWx5Rmo4RmNuUmVnZEcwd1JtS21RbWtWdjdWa0hu?=
 =?iso-2022-jp?B?V29PTFROR1g2LzJTRzZmdVMxM0Z3aXFIQ2twUExpdFpWQ1NKQkJlZmVC?=
 =?iso-2022-jp?B?bGJWT0ZBeUhpczJibDRNZFRWODZxYjhLdGJ1eGpjN0NPbkxZYVo3dHRN?=
 =?iso-2022-jp?B?RnpOWjlxVW1hN1B6MUhEa2xhZi92SU9lWWhFVEQ2dENQMUhKS0xqZU8r?=
 =?iso-2022-jp?B?TXZjcjRuOXh2MUdaaTE4MS9mVlVyWnV5cXZZOU5GaFpvUzNqUDF2aVRq?=
 =?iso-2022-jp?B?UjBSN3k4SUxGTVNBekVUaUlqclhHK1pNZllMUkIzTlZzRHZtZVlZaGE5?=
 =?iso-2022-jp?B?RjJsL01wblY2MjZDVEt4MFhXdnVCQTdRMXNrZnJ4RzJnRmJ2ZXE3YW9N?=
 =?iso-2022-jp?B?eTVoMkVpTzRTYlNLcjQwT0orTXhvdEVlZXpXQjdIZmFud1pURlJaTElP?=
 =?iso-2022-jp?B?aUh6OTNPL1Bnemc5Yy83M0VEaEpoS1NDTFJjMDdJUXpRTWJOWkhlMkJ3?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aHdpS2ZDcHVtSnZXUEdjZjUxTFF2NndiUTlQSnN4bU5aelBMVzlDY0x1?=
 =?iso-2022-jp?B?bmhSbk1OTjdzQ1lUUUxtSnNhVTByVEtrRk1kL0dha010dkZKb1VNcUJa?=
 =?iso-2022-jp?B?VUlBNmhtTFo4cGNCUkcyaE8yL3hKbHlldFlSWXdVeUJ3b0dPalNpU0d5?=
 =?iso-2022-jp?B?UEVsdW1uZTFCYkJHSkZwMWwvR2M1c0dkd0RlOGhGb3F3VDZYZ0N4N1pB?=
 =?iso-2022-jp?B?ZEVzK3ExY2lyNFlHc1AyY2VkNXBobFdGUEdoMFpnRTVHNis1V2d1ejht?=
 =?iso-2022-jp?B?REV2YjJTVTM3NFJwcFJac0tKaXdxUjZFb21vb2ZKd1kyWTVFdElpbU1n?=
 =?iso-2022-jp?B?eFRwN3pjZ290MVVoZjRQdDZXbWtaeVBBOXc1anVKNDRiLzdzZUVNY25s?=
 =?iso-2022-jp?B?d0JxQ3QrVExkb083Q2pnUkdHMXNlazNxd2RqNFlBQm9UNzM2dm5EdW5I?=
 =?iso-2022-jp?B?S2hDYUVrVUdGeHRnU1FpUTVpMkZVK0pJQVpHakJ5bTN6ejNrZjdTSDVt?=
 =?iso-2022-jp?B?S1EycThvZkRBYzE0d0hncXUveW96YkI1eUJ3T2o4czhsdmFhaGlZOVAz?=
 =?iso-2022-jp?B?TUdsUnRPSFZoNnVwZCtMWVRCS2VKZTVPY0FNb0Z4TlB5TmEwanpaRmp4?=
 =?iso-2022-jp?B?RDRlTzZEV1dqbmdmdk5ZczhTUUJnYmFXVHRtVXVxN3QzUmVCSmJ0dXNS?=
 =?iso-2022-jp?B?NkF3Y1pEM0h1YlhPQWRvMWxud2ZuV3NiUEk4VFhub3NoY2hJK2IvcnE4?=
 =?iso-2022-jp?B?WW1UQk9BUm9CTS9WSlVLWVhkdFF3MGNvTWZsRUhsdm5QSkFBY1YrRUtj?=
 =?iso-2022-jp?B?Rm4weE5hZGRYeFgvWFVTMGZOUk9ZOUlvNC83WFVBYThvQm1XN05tVzQ5?=
 =?iso-2022-jp?B?dEhwd3VPNnlpMDh6bUgvWDVRaWxVRFFKSmpMSFBGRjhhbUZQVFBFVGpO?=
 =?iso-2022-jp?B?K3NSWjB0UlZyWFVCQjJtZUxsUWVieFhnWHhON21PNHUxZWN5Rno1T3My?=
 =?iso-2022-jp?B?MlRvU3V1aTVHTGc0NWFWdUsyWXBiTDRHL2VMWGF5eXZEM1RaZW5OZGh4?=
 =?iso-2022-jp?B?WnVlZGpsREs2VFZBMzJsZU9FS09kb0svbG01WHc2VzFnRVpiSVZmSVhq?=
 =?iso-2022-jp?B?RmVSTEswY2RWVFhsb0NXUFhMOXA2cFA3OElUS3JaaGpMZWNkbHo4RCtJ?=
 =?iso-2022-jp?B?RkJVUnVrSkxUMXZnSmtXb203eEoyMTNTc0syN0Z5Znp6aGxhUzFyWmdM?=
 =?iso-2022-jp?B?V3dHTGk4WGh4Sm1CY0Eva3YydkROMXdZY3oxMndQb2QyT29ickRXb1N1?=
 =?iso-2022-jp?B?cUlHVklpaThSY3hZRHh1RzFkR2llYm5PZ0lvcTlEd0w0UmM1RDJWbFNt?=
 =?iso-2022-jp?B?QTAwaU1FL0k0QmlsWnlDZkN4QmxPcTNPRVBvcTVucE83Z2xXK2NWVmd0?=
 =?iso-2022-jp?B?WFhwWkxSYzYyaVduSWZIKy8rZkNaS3RGaWx5USt0b21mQ1ZTcGFSMkdX?=
 =?iso-2022-jp?B?TWg4SHFzbXJZSXVNa0lWK1A2cXdsUEppdHJ1YnMwOXE5VWk2NDY4aGhV?=
 =?iso-2022-jp?B?bjhTcEZqa2p5Ylp3OE9NakJvSGt0MmRLVFIyUTZoNkhrcFNOL0hhTzlH?=
 =?iso-2022-jp?B?R0FhRFY0WGNFOTA3UFBZQkcxYzdYeEdsN1BLV1dqN0lvaTlkS3dGajlP?=
 =?iso-2022-jp?B?ZHFLbTloNVRCT1NGTUxvK0pyM1FGdUxWVkIrRGFnMEd3djVSNnptTWU1?=
 =?iso-2022-jp?B?OGlEUkNISzQ0Yms1UlhLNW5zN3Qzc1hsZ2hFNm9nNE5RMEhUWlRxaDJn?=
 =?iso-2022-jp?B?Y2JhUzQ1bmcwb2VuTkxtcmJDVm9IY0h5alhuNTZyb0VQdEp5UWIzdVRC?=
 =?iso-2022-jp?B?YWdvTVR1OHJZcEQyUG1iKzRjalNEalR5TEppYkxHRHROVllTVTVOcHdZ?=
 =?iso-2022-jp?B?bnlpcFFiV0I5SDY3eEJGaUR3N09oK1NickpSbUlQNXRWQjlHRnZFdEI5?=
 =?iso-2022-jp?B?RS81S0FFWHJkbVFKQXZFaWxYSWJadm1YY3dPTU9qVWJzRGkzdlBUMjJU?=
 =?iso-2022-jp?B?NTdHYTRwN1RsY3NqSHJyMUYyNCtoUTNqbGRtZmJIR1ZrVkNDUGFyZVUw?=
 =?iso-2022-jp?B?eVpkejN3L1hrTnB0clh2L0ZRQ3orU3JkTFlsSHU4YXhDTkw1bDRuU3ZB?=
 =?iso-2022-jp?B?c1lhTnc3NVlpQ0dGUXQwOVlCcTdTemFxRlg5UkJqYnRwN3podDdBalFS?=
 =?iso-2022-jp?B?SXRNdXJFMkhybUN3aWhLVEN5a0NIckl3a2lIYjl0OE9BbDNwMnM3YWpH?=
 =?iso-2022-jp?B?NGtpa2svZDVrc3JndDMyVENieTEySzRiSVlkanhXUE9FN0ZDdkxSZ2Js?=
 =?iso-2022-jp?B?eWptN1U9?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB11075F2400D6FB592B37DE2A5C7E62TY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad54694c-a13c-4c1a-92fe-08dc7005b147
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 08:54:53.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: swIqwuKFZgTyLM7iLJoQ94nMSmAj+OvyBnoX2Y4KUl2ocFymFG/Hqd44dIuiu0FqlGb4jYaNwrjV0Ptlyvw2kr+FYuUvWdKaEnf1RrsAvaQU+KASEPyOJjuCwh70Kv+Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6354
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 May 2024 08:55:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15870

--_000_TY3PR01MB11075F2400D6FB592B37DE2A5C7E62TY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Quirin, Chris

@Quirin Gylstorff<mailto:quirin.gylstorff@siemens.com> Thank you for creati=
ng a branch to test generic kernel configs for x86.
I checked out your branch =1B$B!H=1B(Bqg/merge_kernel_configs=1B$B!I=1B(B a=
nd created image for qemu-amd64.
Locally I also tried to boot the image but it failed with below message.

Booting from ROM...
This kernel requires the following features not present on the CPU:
movbe
Unable to boot - please use a kernel appropriate for your CPU.

Thanks & Regards
Shivanand K
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Quirin Gylstorff via lists.cip-project.org
Sent: Wednesday, May 8, 2024 9:46 PM
To: Kiszka, Jan <jan.kiszka@siemens.com>; Chris Paterson <Chris.Paterson2@r=
enesas.com>; Schilling, Benjamin <schilling.benjamin@siemens.com>; dinesh k=
umar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>;=
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>; cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Generic x86 kernel configration

I will investigate it.  I think this be one of the cases were automate merg=
ing will fail.
Quirin
________________________________
Von: Kiszka, Jan (T CED) <jan.kiszka@siemens.com<mailto:jan.kiszka@siemens.=
com>>
Gesendet: Wednesday, May 8, 2024 6:03:38 PM
An: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>; Gylstorff, Quirin (T CED OES-DE) <quirin.gylstorff@siemens.com<m=
ailto:quirin.gylstorff@siemens.com>>; Schilling, Benjamin (SMO RI R&D F SEC=
) <schilling.benjamin@siemens.com<mailto:schilling.benjamin@siemens.com>>; =
dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com> <dinesh=
.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; Nobuhiro Iw=
amatsu <iwamatsu@nigauri.org<mailto:iwamatsu@nigauri.org>>; cip-dev@lists.c=
ip-project.org<mailto:cip-dev@lists.cip-project.org> <cip-dev@lists.cip-pro=
ject.org<mailto:cip-dev@lists.cip-project.org>>
Betreff: Re: [cip-dev] Generic x86 kernel configration

On 08.05.24 18:00, Chris Paterson wrote:
> Hello Quirin,
>
> Thank you for your work on this.
>
>> From: Gylstorff Quirin <quirin.gylstorff@siemens.com<mailto:quirin.gylst=
orff@siemens.com>>
>> Sent: Friday, May 3, 2024 4:58 PM
>>
>> Dear all,
>>
>> I have used a forked version of [1], which you can find here[2] to
>> merge the following x86 kernel configs together:
>>
>> cip-kernel-config/5.10.y-cip/x86/siemens_server_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/toshiba_atom_baytrail_cip_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc127e_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/plathome_obsvx2_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/cip_qemu_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc227e_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_iot2000_defconfig'
>> cip_core_merge_kernel_config/recipes-kernel/linux/files/mcom.cfg'
>>
>>
>> I have tested the v5.10.214-cip46 version of the config with qemu-amd64.
>> The next step would be to check it in the cip lab on the real hardware.
>>
>> The script takes the Kconfig entries of the specific kernel version into
>> account. It also adds all dependencies to the config. You can find to
>> log of the merge at [3] and the diffs to each configuration at [4].
>>
>> An first integration into cip-core can be found at [5].
>>
>> Any comments from your side?
>
> I had a go at building/boot testing the linux-cip 6.1 kernel in our GitLa=
b CI setup using your merged config:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/128347680=
1
>
> It built and booted okay on the ipc227e.
> However, it didn't boot on the qemu setup in our LAVA lab:
> https://lava.ciplatform.org/scheduler/job/1129968
> "This kernel requires the following features not present on the CPU: movb=
e"
>
> I don't know if that's an issue with our qemu setup or with the kernel co=
nfig.

The CPU type the kernel supports/expects is a choice. I suspect that
merging multiple configs shifted us from "works with generic x86"
towards "only works on Intel-whatsoever". Combine that with a
restrictive CPU type selected for qemu/kvm, and you get that kind of error.

We should likely tune the common config for generic x86.

Jan

--
Siemens AG, Technology
Linux Expert Center

--_000_TY3PR01MB11075F2400D6FB592B37DE2A5C7E62TY3PR01MB11075jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Hi Quirin, Chris
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><a id=3D"OWAAM59C3BA311885=
453289728D72CAFE9AFA" href=3D"mailto:quirin.gylstorff@siemens.com"><span st=
yle=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:none">@Quir=
in
 Gylstorff</span></a> Thank you for creating a branch to test generic kerne=
l configs for x86.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">I checked out your branch =
=1B$B!H=1B(Bqg/merge_kernel_configs=1B$B!I=1B(B and created image for qemu-=
amd64.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Locally I also tried to bo=
ot the image but it failed with below message.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Booting from ROM...<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">This kernel requires the f=
ollowing features not present on the CPU:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">movbe<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Unable to boot - please us=
e a kernel appropriate for your CPU.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Thanks &amp; Regards<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Shivanand K<o:p></o:p></sp=
an></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;
<b>On Behalf Of </b>Quirin Gylstorff via lists.cip-project.org<br>
<b>Sent:</b> Wednesday, May 8, 2024 9:46 PM<br>
<b>To:</b> Kiszka, Jan &lt;jan.kiszka@siemens.com&gt;; Chris Paterson &lt;C=
hris.Paterson2@renesas.com&gt;; Schilling, Benjamin &lt;schilling.benjamin@=
siemens.com&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-size:1=
1.0pt">=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.=
0pt;font-family:&quot;Calibri&quot;,sans-serif">
 TMIEC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;; Nobuhiro Iwamats=
u &lt;iwamatsu@nigauri.org&gt;; cip-dev@lists.cip-project.org<br>
<b>Subject:</b> Re: [cip-dev] Generic x86 kernel configration<o:p></o:p></s=
pan></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">I will investigate it. &nbsp;I think this be one of =
the cases were automate merging will fail.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Quirin<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">Von:</span></b><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Kiszka,=
 Jan (T CED) &lt;<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@sieme=
ns.com</a>&gt;<br>
<b>Gesendet:</b> Wednesday, May 8, 2024 6:03:38 PM<br>
<b>An:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;; Gylstorff, Quirin (T CED OES-DE) &lt=
;<a href=3D"mailto:quirin.gylstorff@siemens.com">quirin.gylstorff@siemens.c=
om</a>&gt;; Schilling, Benjamin (SMO RI R&amp;D F SEC)
 &lt;<a href=3D"mailto:schilling.benjamin@siemens.com">schilling.benjamin@s=
iemens.com</a>&gt;;
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a> &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@t=
oshiba-tsip.com</a>&gt;; Nobuhiro Iwamatsu &lt;<a href=3D"mailto:iwamatsu@n=
igauri.org">iwamatsu@nigauri.org</a>&gt;;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.=
cip-project.org</a>&gt;<br>
<b>Betreff:</b> Re: [cip-dev] Generic x86 kernel configration</span> <o:p><=
/o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">On 08.05.24 18:00, Chris Paterson wrote:<br>
&gt; Hello Quirin,<br>
&gt; <br>
&gt; Thank you for your work on this.<br>
&gt; <br>
&gt;&gt; From: Gylstorff Quirin &lt;<a href=3D"mailto:quirin.gylstorff@siem=
ens.com">quirin.gylstorff@siemens.com</a>&gt;<br>
&gt;&gt; Sent: Friday, May 3, 2024 4:58 PM<br>
&gt;&gt;<br>
&gt;&gt; Dear all,<br>
&gt;&gt;<br>
&gt;&gt; I have used a forked version of [1], which you can find here[2] to=
<br>
&gt;&gt; merge the following x86 kernel configs together:<br>
&gt;&gt;<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/siemens_server_defconfig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/toshiba_atom_baytrail_cip_defconf=
ig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/siemens_ipc127e_defconfig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/plathome_obsvx2_defconfig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/cip_qemu_defconfig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/siemens_ipc227e_defconfig'<br>
&gt;&gt; cip-kernel-config/5.10.y-cip/x86/siemens_iot2000_defconfig'<br>
&gt;&gt; cip_core_merge_kernel_config/recipes-kernel/linux/files/mcom.cfg'<=
br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I have tested the v5.10.214-cip46 version of the config with qemu-=
amd64.<br>
&gt;&gt; The next step would be to check it in the cip lab on the real hard=
ware.<br>
&gt;&gt;<br>
&gt;&gt; The script takes the Kconfig entries of the specific kernel versio=
n into<br>
&gt;&gt; account. It also adds all dependencies to the config. You can find=
 to<br>
&gt;&gt; log of the merge at [3] and the diffs to each configuration at [4]=
.<br>
&gt;&gt;<br>
&gt;&gt; An first integration into cip-core can be found at [5].<br>
&gt;&gt;<br>
&gt;&gt; Any comments from your side?<br>
&gt; <br>
&gt; I had a go at building/boot testing the linux-cip 6.1 kernel in our Gi=
tLab CI setup using your merged config:<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipel=
ines/1283476801">
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1283476801<=
/a><br>
&gt; <br>
&gt; It built and booted okay on the ipc227e.<br>
&gt; However, it didn't boot on the qemu setup in our LAVA lab:<br>
&gt; <a href=3D"https://lava.ciplatform.org/scheduler/job/1129968">https://=
lava.ciplatform.org/scheduler/job/1129968</a><br>
&gt; &quot;This kernel requires the following features not present on the C=
PU: movbe&quot;<br>
&gt; <br>
&gt; I don't know if that's an issue with our qemu setup or with the kernel=
 config.<br>
<br>
The CPU type the kernel supports/expects is a choice. I suspect that<br>
merging multiple configs shifted us from &quot;works with generic x86&quot;=
<br>
towards &quot;only works on Intel-whatsoever&quot;. Combine that with a<br>
restrictive CPU type selected for qemu/kvm, and you get that kind of error.=
<br>
<br>
We should likely tune the common config for generic x86.<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Technology<br>
Linux Expert Center<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_TY3PR01MB11075F2400D6FB592B37DE2A5C7E62TY3PR01MB11075jp_--


