Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CFFCD8CAD
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 05:56:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73030.1780984569521736111
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2026 22:56:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 6595u7Rp2750484; Tue, 9 Jun 2026 14:56:07 +0900
X-Iguazu-Qid: 2yAbopOybyOXobEGnB
X-Iguazu-QSIG: v=2; s=0; t=1780984566; q=2yAbopOybyOXobEGnB; m=uU9X8ZyPfo4XUERpVE00BZVIKsdQAuDAiEWkHZFlHis=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gZJ7B633bzyPg; Tue,  9 Jun 2026 14:56:06 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5dzpMq94Pj8YDItMkjD064KJXLbm84yIbWvDuIXEztRZ4vpoP7M5P5BFvUdz9pZn/g3LNBVvTuZn1HZGSA3CPanc5SqiqBRiO3KPWT0t1oOqM4BTBo4ReZZKNVDy8DTx87acmkKVnkoidUgVsPvKTvydVagetgs60PaM3H/6jz6s9S7OKhQKIw9iNQ2c2mMNlznvK39YCCnmMMpTXqdJAVy6WZ3KwXth2UR1N4S/ibQ/iFa/KbutnADhviJmkWkrGWy02qtg+P6lpWxCf139i5vE47DwFcEU5IvaJC8kNibeddaIl+XGqEOWIiRYmkRSf8t9aiIRBQFCp8UF5j62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkmJTvYSB4VJ6cpsTfD91CjpQYa/zvQ+mFL81x250Hc=;
 b=wej3HQefNi3ereXRxllli6fsjHloTMJHH++OmPGx6/5beV6voXrHN+VJakwECPglhx8JT44OqkkcIUUQMPAXd8NN9C3eiSwWspqh0Gz1nI6Yxn60TBtWvcE9Ru0jqNrzMF76G7lvXKe2az/vusNq9goGDhXtJ3EjW0r02TxdHPlPUQzkX1hQLZYQD7W9KnkEXt0vaRlSgxh01lFIyQwYChM0rTOHJLwn9NZh6Ar2/e0SK85LCt1tRX3TgY3IrfTPKPm2cKH9JkwistvQ5KIO9buYfD/ZN2iWPEFDA8z75ANKWLWyf6fD8w4oCQyj4H6bkRDRwF/86F/gHmCkcY/p2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <quirin.gylstorff@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1] doc/README.factory-reset.md:
 Minor updates related to use cases and relevance to IEC 62443-4-2
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v1] doc/README.factory-reset.md:
 Minor updates related to use cases and relevance to IEC 62443-4-2
Thread-Index: AQHc8lKhYLqVvJWvnUC/dKcBPNr8RbY0XwoAgAFQzEw=
Date: Tue, 9 Jun 2026 05:56:04 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669E47387DC5332A201ECCCC41D2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20260602060009.50354-1-Adithya.Balakumar@toshiba-tsip.com>
 <8942785c-f7de-4c3d-9dbe-b8cf290d591e@siemens.com>
In-Reply-To: <8942785c-f7de-4c3d-9dbe-b8cf290d591e@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS9PR01MB17813:EE_
x-ms-office365-filtering-correlation-id: f1aa84d9-965a-4b50-9c7c-08dec5ebcae9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|56012099006|8096899003|3023799007|4143699003|6133799003|38070700021|18002099003|22082099003|95630200002;
x-microsoft-antispam-message-info: 
 JZJZ2xbkSmzC1zVYZgUODoFuUNJZgJ5qYQWiyS9IWW49MWxHSr9WTBZLzVJN5QKH5xdkqspn/aftVePbmSnRVJGD6rear17lOxiwS5wLE9Qy9vIUjuBJSJFL5E7sRmcX0iORZmp8Wf2Tmwkz3zaf9g1ulP4eJjowZ/NE8PvuS6Shq+qBMdwf/D8MZMRyCkHwoh9PdeuHhIHQyAIJmFj9+rGKL9l3Yucxn66Q8aB+rrjcTM/BGYkJ/eDIfoD+20KVha7SjVXTeMXKR0OTb64VQ13jUrsxxBuW4vvsRr2gvKajX1k6N7sgeoYVhHAjUvh370n0T/oPlezjliGpewzkL+SYqXqayMEVDDx/bmgAXEzvMXVJyivr7GshjY+fhv0fmonggEivOINxbii/XSs1z5w2u6Aipf4xHWStXtBpfkXLkZDAnXyJJu9/dz9hq8uIOGIIQhrGe2KUzvzbvJvL7JNeDg0c07oZCwsUohWWpLHgj/qwEGwH/PUb0+bxK1OvI6qdqWfjcSSf83x5C735S/sNjzdMk9sbMCxgEPdPznr4EFiEkVgbgOtpq560i7GhAHx+z0NOD931og91YwP7FkzEt9WncJTQ2QnptgFooXjzQlX6ovap6FYaJJqt0u50iBhT3ge7bQRMoGVRxEe4frqQvUDuFEla/VuOVapAneQOv/kCN5ahbxL9VQZH5hkvLY1twwkXKhtN5eGtsa7IJe/LTAke3enNKhRHRgE1CtesPzNPQ4E634MUOipx32M2jtlWlN50Mh7THpYXkNX2hUx/YVeWL8caVKQxoX1wvtY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(56012099006)(8096899003)(3023799007)(4143699003)(6133799003)(38070700021)(18002099003)(22082099003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dVBGbFlGaGlRMDNnNHN5T012Ti92T3RjTGEvODdkd1EwOGtyL1lsaDBS?=
 =?iso-2022-jp?B?WGdDaVM0dzZxamw3cThrcGNtakZyMXFYU3dDZDJGSlZYZkwvNEpLSkNm?=
 =?iso-2022-jp?B?VUI5d25xOGN3Y2s2OVlpZjlPVCtDTFBqdWZhUFNidnpaWXdkeGs2bktJ?=
 =?iso-2022-jp?B?SGRhd2IwQWluTW8rWWZESjR2OWx2WVVwVzY0TThpbm02MGp2VTdRNXpH?=
 =?iso-2022-jp?B?KzBRQ0Ewc2VIMkxGREQvcUphT0o5Z1dRWm9RNW10S2k4YUR3bVZ1NWln?=
 =?iso-2022-jp?B?cTErQnF2WkoxRG1BWmxicnlCa0x4SWVNUHVENjlvMWw4R0JVcWxqcURN?=
 =?iso-2022-jp?B?dEVqODFobnhjcDdmRzltV3NWTlk5b2Q5by9NTDFNMTFNREpVYWU4QWU1?=
 =?iso-2022-jp?B?czR2WjNKZmRiZjRIOHFObWwxYjVtaUh2a3IrWGU4WHA4ODh0QlUrbDV5?=
 =?iso-2022-jp?B?SHBudFFXWWd1MGFCRExaRWtSR1NMcVZwSU9XQUVoNzN0dk13cU5XZnp5?=
 =?iso-2022-jp?B?UFd4ZkhWclZJd1MxQkRlZFdieVZRWGRhMDIvemgwQWppK29Lb013UFJB?=
 =?iso-2022-jp?B?Q3ZtMHRCQlhhaFA0ak85ViswaFpLTHBSbGhENGJmd0RKK0pBVEMwR0tB?=
 =?iso-2022-jp?B?VU5RZW9RbHZFY3MwSEs0K0YwNzNLZ2FKWE9memZicFhqbHZFeCtSZ2ly?=
 =?iso-2022-jp?B?MzVPWjZBZ0tBbzY2dkIrZlBGY0x4bjNzSmpHblcxVURMRnVSdjg3ZEJV?=
 =?iso-2022-jp?B?SFZGZGpGZWpNSmtWakx6elZaUU5MZGZjZXJhSEVGSUwrTjZ2M05QUTF5?=
 =?iso-2022-jp?B?b0YzZWp4UGVabzRrTndlb2tuWWg4MkFDZGN5b3FiemQ2SmdhV3VXUmtQ?=
 =?iso-2022-jp?B?enNFZkxNY3phdUp2dXJibmZlWFBFczV6dEkvakFMb2JORmxZdnhMbndC?=
 =?iso-2022-jp?B?SExiN2NOM0pyOFJrVVVXakgvQi9odENMU3JEYlZBRmsrdXcxeGhMN1dC?=
 =?iso-2022-jp?B?Y1VBcHFBaWVWRFYwRldwcERyR1MrWVpOcFg5bkxwQlNLVVhwTzVKeDNw?=
 =?iso-2022-jp?B?UjVHbmJlQkdSZjUrcE4xY1dLa1V3N2dMQjE4c1VhSVlUV2UydjZTSEM4?=
 =?iso-2022-jp?B?Z0pPekw0VXR1TXlraFlqeWFrU2d2RC9PUThYN0J4YXZLSHczYiszcHVB?=
 =?iso-2022-jp?B?TUlMZUVFOXpzZXhzZ0pyZmdrM3RoUlEwMDhzRmx6WlpFQVZFMWxWajE0?=
 =?iso-2022-jp?B?TzZEZEdhU0dVNjlnLzJ0TzYvQ0p0NXVIRElVV0FxU3NLRTlDWmlMTHBu?=
 =?iso-2022-jp?B?bC9ub05TOU8va3RtYjRNWFpJUGJXQmgrRXBGTGJZRjRMcWE5MzRSckdl?=
 =?iso-2022-jp?B?dGRvTXZLS1RnOWpDb3Q0azRGcldVVmJud1FIMlNqY2YrZ3pzQzdUL1FW?=
 =?iso-2022-jp?B?Slk3dkJjUkZtWFVQdG9XR2ZvMHpyZHNBck5vUFkrREVLck5pUTNDcmRW?=
 =?iso-2022-jp?B?MktjZDBtYmJ3bEFrNTBPVWtDNEErcXlMNVcrRzV3bDk0UlI3N1ZaMGRS?=
 =?iso-2022-jp?B?QmtiSG5kazlsOXhwbWV2TVpmOFpNRnZ1TmduZUprdVBVZldQNjgwOVFH?=
 =?iso-2022-jp?B?MFpJMFN1MjZ3NUhsa0lxY1ozM0hON2czaVhRN29vbXpHRm1TeU9BYzBT?=
 =?iso-2022-jp?B?MkNwZFk0MjdQWkNTRkZqczJKWVZkeDRXekF3VVh0bzZYbElmYk9QcHJM?=
 =?iso-2022-jp?B?eCtyUTNCMWpISEVnaE14MXRiUzJTTzhXN1BoUVN0R1A2VnlXcXBNRlhp?=
 =?iso-2022-jp?B?QzhuWndUZlE0dExLNlduYVp4c3NxdzJxR0I3NGFIOTBrS0FQWG9kOXBo?=
 =?iso-2022-jp?B?Q1pDem40U3F0V3FIVnV0YkRGQlR6SWNkdzFCZmh4Q1N5bVBxMGNMQmJE?=
 =?iso-2022-jp?B?R3JTOXo1V3JLZFJkNEh0aDhMVDltTWJzMmdURnNCZ2ovbmsrb3dhTzdB?=
 =?iso-2022-jp?B?K2Q2Y1lIeGh2b3lzMkdwYnRXeFAwQURJbzYraWJFc0RicXJ2YU5INU9U?=
 =?iso-2022-jp?B?aUJpN28xQ0NoQ2RsdjI1S085VHhTeEtrTjVBVy9RTTFmaE5GTFBkMERW?=
 =?iso-2022-jp?B?L25jUEk2Q0NFZXFLd1FmYThpUzVZS1RYcmhUTFFYb1NIdjBGdjZDUlQr?=
 =?iso-2022-jp?B?b3dFNjBZeStxSm1SZGp0eVRqOE9XQWFJNHpjL3lVRENNUk04L0lMRWth?=
 =?iso-2022-jp?B?UFhjVUgwR1d6WUMxdnJvNWwxK3BMU3R0RGo4UTA5S0d5UHA4VjlYdUZt?=
 =?iso-2022-jp?B?clBNKzJVbldZVU91RFZrZm01OEVHMmRncWJrTU1HMkFURDBsQmUwajNB?=
 =?iso-2022-jp?B?NE85cDByeVdhSVF4V2Z1OGpVMUVTcnVhdEk0WSszanRSenRaRTFHQ3p3?=
 =?iso-2022-jp?B?eWFUbmR0Wk1tQnRiL0JSNzJxOHJGQUxiS05OUFRvai9wMzVHWFNKMnNQ?=
 =?iso-2022-jp?B?UUdsaUw2Z1ppY0l5Z0c1ZFJGREVSeDVFRllNaEp2RU1BRmE2SGtMOVQ4?=
 =?iso-2022-jp?B?TkNXT2E0bz0=?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669E47387DC5332A201ECCCC41D2TYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	MgAKCm8Yc535j2wvwmuoyAxNz9dzGvpZSFPRQr+Pr974fTyhPZkxWbJFi38qelOJe9pK8UI1wxG7g4gPR5+E2SC44toSi+GQhW6Jj5af3B/NkzG42LrSkzZzcgQUfQuEaL9DxEFx3YaCMLx244pch1wHLuKo5+hA2Jp0iweoMdNUmXZDpnb+AgWmuR6oxvm9IkDmA/Tj3/ErYIkXwnprSFWSCifOImTMF6k8bRaSAeZbOAfs8ei1eoXL/VmJP0smg8LK/11mcZKd1nsnLJZeQVkOacOg9XaBKg791QGVl0Ujl9/VGOQaP+zQENCw10SvoDvH2dMc0hxBbEJQlvb5Jg==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aa84d9-965a-4b50-9c7c-08dec5ebcae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 05:56:04.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJOjvu9X6Ha6n5KIHsem4rCGkGmT/blwFFQWv35wQjHkNtZFr6opF0Yyjvxm4LBUQssN66v0nXbx5IcoRzspkiEvZmulmqp5l8LzYY/NdnjpcDjAYP9AYgnU42jfoJB0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17813
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Jun 2026 05:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23053

--_000_TYCPR01MB9669E47387DC5332A201ECCCC41D2TYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Quirin,

Apologies for my delayed response.

>Should it not be Persistence?
Yes, Indeed. Apologies for the typo. I guess Jan fixed this before merging =
:)

While we're on this topic, my intention with this patch was to clarify the =
basic use case of the factory reset feature.

Could you help me understand if there are any other real-world scenarios wh=
ere this feature is currently deployed or used. This is just an attempt on =
my part to gather more information.

Thanks and Regards,
Adithya Balakumar
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Quirin Gylstorff via lists.cip-project.org <quirin.gylstorff=3Dsiemen=
s.com@lists.cip-project.org>
Sent: Monday, June 8, 2026 2:06 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1] doc/README.factory-reset.m=
d: Minor updates related to use cases and relevance to IEC 62443-4-2

Hi,

On 6/2/26 7:42 AM, Adithya Balakumar wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   doc/README.factory-reset.md | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
> index aa8dd1c..419e32b 100644
> --- a/doc/README.factory-reset.md
> +++ b/doc/README.factory-reset.md
> @@ -51,3 +51,12 @@ root@demo:~# reboot
>   ```
>   root@demo:~# find /var -name "to-be-deleted"
>   ```
> +
> +## Use cases
> +
> +- The primary use case is resetting data partitions (e.g. `/home` and `/=
var`). This also resets any configuration changes made under `/etc`, since =
the read-write overlay for /etc is currently backed by /var.
> +- If the `/etc` RW overlay is backed by a dedicated partition (separate =
from `/home` or `/var`), that partition can be formatted independently to r=
estore default configurations (included at build time).
> +
> +## Relevance to IEC 62443-4-2
> +
> +- Factory reset feature helps meet requirements under CR 4.2 Information=
 Persistance. Refer [here](https://gitlab.com/cip-project/cip-documents/-/b=
lob/master/iec-62443-assessment/iec-62443-4-2/iec-62443-4-2-fr-4-fr-5.rst?r=
ef_type=3Dheads#id12) for more details on how the requirement is met.

Should it not be Persistence?

Quirin
>
>
>
>
>



--_000_TYCPR01MB9669E47387DC5332A201ECCCC41D2TYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Quirin,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Apologies for my delayed response.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;Should it not be Persistence?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Yes, Indeed. Apologies for the typo. I guess Jan fixed this before merging =
:)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
While we're on this topic, my intention with this patch was to clarify the =
basic use case of the factory reset feature.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Could you help me understand if there are any other real-world scenarios wh=
ere this feature is currently deployed or used. This is just an attempt on =
my part to gather more information.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks and Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Adithya Balakumar</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-proje=
ct.org&gt; on behalf of Quirin Gylstorff via lists.cip-project.org &lt;quir=
in.gylstorff=3Dsiemens.com@lists.cip-project.org&gt;<br>
<b>Sent:</b>&nbsp;Monday, June 8, 2026 2:06 PM<br>
<b>To:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project=
.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [cip-dev] [isar-cip-core][PATCH v1] doc/README.fac=
tory-reset.md: Minor updates related to use cases and relevance to IEC 6244=
3-4-2
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Hi,<br>
<br>
On 6/2/26 7:42 AM, Adithya Balakumar wrote:<br>
&gt; From: Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsip.com&gt;<br>
&gt;<br>
&gt; Signed-off-by: Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsip.co=
m&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; doc/README.factory-reset.md | 9 +++++++++<br>
&gt;&nbsp;&nbsp; 1 file changed, 9 insertions(+)<br>
&gt;<br>
&gt; diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md=
<br>
&gt; index aa8dd1c..419e32b 100644<br>
&gt; --- a/doc/README.factory-reset.md<br>
&gt; +++ b/doc/README.factory-reset.md<br>
&gt; @@ -51,3 +51,12 @@ root@demo:~# reboot<br>
&gt;&nbsp;&nbsp; ```<br>
&gt;&nbsp;&nbsp; root@demo:~# find /var -name &quot;to-be-deleted&quot;<br>
&gt;&nbsp;&nbsp; ```<br>
&gt; +<br>
&gt; +## Use cases<br>
&gt; +<br>
&gt; +- The primary use case is resetting data partitions (e.g. `/home` and=
 `/var`). This also resets any configuration changes made under `/etc`, sin=
ce the read-write overlay for /etc is currently backed by /var.<br>
&gt; +- If the `/etc` RW overlay is backed by a dedicated partition (separa=
te from `/home` or `/var`), that partition can be formatted independently t=
o restore default configurations (included at build time).<br>
&gt; +<br>
&gt; +## Relevance to IEC 62443-4-2<br>
&gt; +<br>
&gt; +- Factory reset feature helps meet requirements under CR 4.2 Informat=
ion Persistance. Refer [here](https://gitlab.com/cip-project/cip-documents/=
-/blob/master/iec-62443-assessment/iec-62443-4-2/iec-62443-4-2-fr-4-fr-5.rs=
t?ref_type=3Dheads#id12) for more details
 on how the requirement is met.<br>
<br>
Should it not be Persistence?<br>
<br>
Quirin<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
<br>
</div>
</body>
</html>

--_000_TYCPR01MB9669E47387DC5332A201ECCCC41D2TYCPR01MB9669jpnp_--


