Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF001C83F0F
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 09:18:52 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.44])
 by mx.groups.io with SMTP id smtpd.web10.14394.1751966324100340681
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Jul 2025 02:18:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=EeNtyYAR;
 spf=pass (domain: renesas.com, ip: 52.101.229.44, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aroFBtXPCWxn106YZjNbiDYIpokvZClVrNXqwD+LM9hn+YR/bpzgThyTbT76V9S0ZmxUaACElFBQ5CnGKugXPzOlWYDwEp7eDjFzq0bCeaj64DmdzVVrLiJW7U78JpLA87Hs81f86VDFRQGBU11bxyfw1JMGwNU0hfAT57ZhHrC/xtC1Pgz9WwG2d7iGymv6GUIp0w9oAqZOIzWcFmJeIPrxdPFgjNgpMfK2dF/iGRS6sTREvXngmwPQnyB+V7cXRYNvKju1pLkA4ueEYh5cMkSfGBoDk/f9o86TLNgbH8azthKd9pzvnO+ZW5ejspFD5riU18gkkcVKU8IpsqUs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXOrDB7NiHnrsTiWznT2vuA11gXYt5hWv3t+GZBvq9o=;
 b=KtokH1U71Ae+nJC9FVvndhFunt+lGzeMg+dZUNIo7hvXCXO6aakF76ClQ3qOepkR1Yzw9T+m0QdZXSkM6gQP60excKvsA4njTkLX2laUTsLOYcLiyZRRKBQiIq8H7T9wLCzmtpRtEnbkT5V7rddpzOmkbJFWTDnrFf283XEzLY+xBXLeePlBOzUAYZNxEMPau03akI2SDAf/cf3PVbrzZIa4AGOaAiiADEeibqOgCxdSTQCoeYDT7Q0siSuhpYz5HLa/kK/rWwRupem8KsQtNAnGTC2jYqUKCUHKXp2ZradyD1f0eBlr9eXWVhEma6pccmaWxCMbskp63S3Tw2znbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXOrDB7NiHnrsTiWznT2vuA11gXYt5hWv3t+GZBvq9o=;
 b=EeNtyYARNRslF/PxqHZOefeMpF7eX65ZClZapmfy4uivd9QZwzOyamABGRxt7aDlVFAcGatsPeS1Vj70P2FZojzGjDtyPL+lGkEowdc/gJdVe9js+w+5/8vMUG92oCEmEjdmUqlm7X4HCIfBsbLnj24HH38OCMMWP+vHodBoKgc=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by TYCPR01MB10244.jpnprd01.prod.outlook.com
 (2603:1096:400:1ed::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 09:18:38 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 09:18:37 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Simon Flutura <sf@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Testing -- plathome_obsvx2 has problems?
Thread-Topic: [cip-dev] Testing -- plathome_obsvx2 has problems?
Thread-Index: AQHb7yaCnfDZy1xgNUS/XUyCC3RMfrQnIx2AgADQqLA=
Date: Tue, 8 Jul 2025 09:18:37 +0000
Message-ID: 
 <TYYPR01MB15132DDA30135D6B4AA952D3CB74EA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <aGubmZMZYf7Ww9EP@duo.ucw.cz>
 <TY7PR01MB14818CE73D1A4198D3C4C9745924FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB14818CE73D1A4198D3C4C9745924FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|TYCPR01MB10244:EE_
x-ms-office365-filtering-correlation-id: 342e7099-af3e-4063-fcca-08ddbe006c10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Y09OVjBpWXAwQ1MyNThydEJOWkR5TFdEZC9wais3M0ZQRWd4MklDN0g5?=
 =?iso-2022-jp?B?NXQ0UVRlZmNOWW1zaVlYQ1JsWlVaZUdEWjgxcDlVVDZGQmJKYSt4M0Qz?=
 =?iso-2022-jp?B?MEtNd2hHM2hicXZnZ1hBcUJaOU1aaHdSdlhnV2F0bWVwYlovcTcwOVNG?=
 =?iso-2022-jp?B?TnpGenI3b2w2elY2TlF4SzBDd1BvbGRxdTk5UlhQdXZDbEVWeEdEdW1V?=
 =?iso-2022-jp?B?TnRqblY1WlVNekZkNlRtaHB0Z2NFWUw3KzlqWE41bFBnMjY3aFFoTFp3?=
 =?iso-2022-jp?B?ZXUxamwvUUJNOE1ObjBmdmgyc1FtN3ZHcHNmcE1rM2luUjRkS2IzYWxn?=
 =?iso-2022-jp?B?ZXJ1NVkvUW5IK1A2ZjFNNk1HaHpqNm12ekhSeTVpWXNQOVUzT3ZhWElY?=
 =?iso-2022-jp?B?bUtLcWJuc1c5N2U3Z1ZtblAvdHF0YW9lZGNNVTNHaTNsK29KWmRBd1pH?=
 =?iso-2022-jp?B?Rms0U3gxUk8rSVcrWTA2UE1CbGpuUWVUU0JKSEhMamRndGpjUzR4SjI2?=
 =?iso-2022-jp?B?aVJyb1VmR3dtSGlJNUJyS3dyaElXT2szWWxaYXA1OGQzNlp5ZkwzNHRa?=
 =?iso-2022-jp?B?bUUrWEJmVjZ4MGV0SXF3SU41bm5MbnJyL1JBNFk1WlBxNkxrUy93ZEds?=
 =?iso-2022-jp?B?a3pxUWZjMkwxV3Fnc0FNRldYdWFSbFVDcWNqaWViSVY0eVFJRUJGaXdo?=
 =?iso-2022-jp?B?cUxSQWo1Tjl5WGU0Z0s5S3BsYXNzeStQekozR2F1dXdkdHlocHRNYlBJ?=
 =?iso-2022-jp?B?M0w4d1FYcEhRMCs0UUIyWjVydm1QVzNoSFErZTJRVWQ5QlVYak14Njl2?=
 =?iso-2022-jp?B?aStvZ1l5UHR5TWdYOEZiTWxiWkQ5dGt1RkVLUWtHYWdRdDlOeU1NajVB?=
 =?iso-2022-jp?B?ME5ZdDNwMnZRVEN2ZnJaeWVRZ1UvV3BXSEh3VkZHckJUVVhPVENZKzF5?=
 =?iso-2022-jp?B?MUlyQlg1bzN6WEZQYmZGcGtKMnM1d3owVUZDMzhqVmRVNHVCNDJ1TXN2?=
 =?iso-2022-jp?B?SlNUR205RWdmWHVvZHN6djJ4SDc4Q0NKclM4MnRoTFFEMENWdHl5OTNs?=
 =?iso-2022-jp?B?UnNITGlNVEdUTU03emZVMkhMOVZLY0VNSXRVRlJ1K1FNZXhJcTh3Q25E?=
 =?iso-2022-jp?B?dVZHdjZDOGk1RUUvMEFDL01MRjRacGpELzJUbVNLd255Y2RpeGZUK2Vj?=
 =?iso-2022-jp?B?Nm5VSHcrWkQxRkdRZ0pCa1J5UkZUT2xUUEtQcmhuM2Q5VkJsNlpGSXhk?=
 =?iso-2022-jp?B?diszS0x3c2NSemVjVWZxaTZLNDVzcUQ0bytiUGVBaytSZ3hiNHNHNE1R?=
 =?iso-2022-jp?B?bVlRZXNqRjZnZHV3YzhlZDRzUmhXVmU3YzltaisvZVZjTW93UldWcHZF?=
 =?iso-2022-jp?B?N1dxbE5OcTVhOGlObXhBcGhoUDJHa2FzWGpiOGw0WjN6YW9wcVMvYzdU?=
 =?iso-2022-jp?B?dDdWMGZuOGNSelBqRWNZZ2F2TmxLSmc0ekptc2I2MlVZZTlFM2ZMbU1j?=
 =?iso-2022-jp?B?NmUrUUJrd1p2N1FyemJnZTFXRjJScWk0dmRuSHRuWWw5dVVDYnk0U05a?=
 =?iso-2022-jp?B?c0FvTVJUMDdyVjJxRlB6YUxqV014L0ZyRVVHNDFydWs0d2Q1NDRTd2JH?=
 =?iso-2022-jp?B?Y291OGJIK1Q5OVB4VnZnMnBRMm54Tlk2N0c0UHVZUUhsdW51U0FLNzJy?=
 =?iso-2022-jp?B?K0h0cUVJbEF5MEVEUkRjVVpncHdoY0I3cWVsdUtISHRuVjN6ZU1RVXVq?=
 =?iso-2022-jp?B?VHptVVFMN1AvRk9BdHlBOEtXV3JnWUVqTkFDcnZTSUZlMVhHbmMzTmgz?=
 =?iso-2022-jp?B?Z0llZTNjNTBsbDRIaHhSZEpPMGQxcEI0WEVzL2tGT3dLK0JkVjBEQmdK?=
 =?iso-2022-jp?B?V1pMR1NZNm9rbWZTZjFWQkZPRWozODl1OG1TTUh5NUI5VjBaaUJQczR5?=
 =?iso-2022-jp?B?L29ZUVV2MHJ6OUZCZ1FVckcwWGl4VmVHTGlBcFZYLy9ESDJJeitzaW00?=
 =?iso-2022-jp?B?cm5kVGpJVVFwWWZlL0FPbFJHUkV6R0NEKzEvd1JzWmRRa1R5TnVpaTlJ?=
 =?iso-2022-jp?B?aldHQ0N1WFd4SW1pVk83V2ZNVW5VWTA9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?d2hTRW1UMGZYWHlnRXh5bE83YnYzSzJZb3ZkZk9ybWtIQ3FlQmVmdDAw?=
 =?iso-2022-jp?B?dVBnQVBrbnJmQnIzbDBRRHJud1QzV0pDQ3Rha3N5RzQ1SkQ0YSt0dmdv?=
 =?iso-2022-jp?B?NWF0bXF4b2JWQ2dnNkdWdk4weXdYN244VWhMOWZwYjVKWHdhNkZudkRT?=
 =?iso-2022-jp?B?WVcrazliMUplSTc5TGlxOXJLakllU0dvUUQ1RDZRbUlMWGZDdEZBRDFR?=
 =?iso-2022-jp?B?Q21JQWV4T0VmR0kwZWlCODJPbnVrUThGZW82MlhTU0QySHA1QndidU5H?=
 =?iso-2022-jp?B?L1BzUmFyc0pmSE93dHJXNit0azhZV1p6TWM5RElEMFY5ZVZ5cW8zS3cw?=
 =?iso-2022-jp?B?b3FkVzVtUURIVjRXYjlpRjFuWGRtSm1qblllZHBTOVczN29FSG5OL1FJ?=
 =?iso-2022-jp?B?alMzVllEVHNWSFpjTUZwZkJMMFBRUG9ZL1RIMk8wL0V2OXN2NURCVzlI?=
 =?iso-2022-jp?B?UEZscDRpeTVvdDdQd1d4SGpGQzFwR0VoVThxWWxhU21QcGpWWTAxNUg1?=
 =?iso-2022-jp?B?ZGxvdDU1MjJwdjYzYlczSS9ZSjBtZFdsaUMzRWU1TlMyM2RxRHBscTJT?=
 =?iso-2022-jp?B?TGN6bThXSzZ1bFBCeER5eVVhaVhBenpsbWp1ejVtNlNPbEtLc0NjZ2lS?=
 =?iso-2022-jp?B?SU9sZEhpck9NdjlVOHhmZVJSUURXczZ3VHV5eCswQVBqaUd1MkUvbGg5?=
 =?iso-2022-jp?B?SGx5WTl4QXhuZHZrRkZ2R0VlemFiWlFOd05HaXZKNkMyUGhmRFE5QjZV?=
 =?iso-2022-jp?B?dUlHUWs5SU9tcjZ2cFREalVBWk1jU0wxODYzRlQyWkxwRUg2d2cyOHdK?=
 =?iso-2022-jp?B?bEs0c0VkeE14MUVLT0tPVVFYc3ZhenhJd2RHQ3pZaUg4NCt0T3VpWFVm?=
 =?iso-2022-jp?B?eFlPVE95SzB2bWdpRkU2dDFpWXZ4Q2ZOckR2MEswSm5IQndqaUgxOXho?=
 =?iso-2022-jp?B?bGVkekxDbWx6SFJ5cUpiNUtCUGtwTG55QzVLT3pkUnNhWGl3clV5RjNl?=
 =?iso-2022-jp?B?Y1FPZngwV3pudWRjK0IxV2dTWlVFYkVscFdoSTY0MERkRjk5T1hEYmFy?=
 =?iso-2022-jp?B?Rnk2ZzB0dTJabjJqWWFjM2ZpVnY0WUpxUTNkazJ6T1FVaGQ2bXkxcE9R?=
 =?iso-2022-jp?B?dlZ5TU1LbTVtcFRTOCtDTUpxMXFnNVI4a0thaXQySGRsRlFJVmtOSlNC?=
 =?iso-2022-jp?B?MzBOYjNoQ3dRTWxaVjJZaWNtSUxYaWVJNkt3S0ZoZkFDb2pzcDZaQzZE?=
 =?iso-2022-jp?B?RXdEelFENzdYU3ZVeWYvSlptTm4vcm1IVDNmZUd5RjdrK25LUVpiaFZs?=
 =?iso-2022-jp?B?Z3E2WVpjdm9GazM1bEZDYzh3MkltMFBlSm5Ub3RHSXFsMGZUVUIyZnYy?=
 =?iso-2022-jp?B?VFNKeW5SajJDVFpNU2kvUi9PVlJ3bW1tZkFGVzNzUjBPNlE2U2U3SmRU?=
 =?iso-2022-jp?B?aXNlaXd6dEpyQk1MVWZ6bUlNdnhnOXdxck5lYjJuTU5vTUlxeVk5UVJX?=
 =?iso-2022-jp?B?aVo1RWRnSHVISkJmaGZvb1laTkp1Nm1HbVJjWGQyYlY4VHBuZDNpZExh?=
 =?iso-2022-jp?B?ODg1SU1Yb1B4MXJjTHhwUGNVR0V2ZE52NlEzVTArMmpOVnkzTVJHSkxh?=
 =?iso-2022-jp?B?SXJkN3F5dlh0ZnlTVUVRNUdhUGJJOFB5VlF1OVpCNURPTFZDaUFnbXlq?=
 =?iso-2022-jp?B?QXpGOWpTYTRBNmk3RHVabzIwQVFibyt3OVlucDNueXlEajhUTzIzb3pa?=
 =?iso-2022-jp?B?T1ZtSVNYRjVBdk52S2NSek90dEx4REtyZDEvZVR0VmFtR1AwZ2o0bERN?=
 =?iso-2022-jp?B?WGtVUFFjd1RicVZnaU9Kb09jUGxRdHBlYjhWbFpLb3JNcjBaSUpySGVx?=
 =?iso-2022-jp?B?UkwrelpXbnBsZVhVYkdjblV1eHFOVFk1WlFQMHZvQ2RCbEV0clFtRTVO?=
 =?iso-2022-jp?B?b2VtNERVd1VhYmMrWjRXaW1UdDhmNUJDU2d3V1kyek83bjBhbW9sZDFX?=
 =?iso-2022-jp?B?SXBZNXRsaHZoKzlFQmRWWnk2NVFYb21FN2pkYW1venBwaU5YeGRBU05x?=
 =?iso-2022-jp?B?VXJ0RDFCNEdGSXJRYVhVUXNoeVh4MzNML1VYNW0zRDFMT1R4RktCNURM?=
 =?iso-2022-jp?B?RjZxeTR1UnE4UlRDalJ2YzBnVG1jKzVsamhLdnJMdVRyOHo5RUVZdGJS?=
 =?iso-2022-jp?B?K0MwdWlNWUgzL1JZVThoaGtBN3plbzBvUkE3RmtkSG90bnloMnZjUmpB?=
 =?iso-2022-jp?B?b2FVZWpZY0NVNy9YMEtkbWFHWWdZME1CQktURnNXTXQwaWVUV29lNHAz?=
 =?iso-2022-jp?B?SENMRHdnWktNdzZ2N0YzanRycHBtMHc2ZlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342e7099-af3e-4063-fcca-08ddbe006c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 09:18:37.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofH+Mcz/4cl/wqPFtsq9IKjlDYXu7DcS33SvVwYt6T4txC6ZFS8GxEmSxUwtQ13RNxSqvblzVBMPHJaY4xYRhXgIrrI9JVPLNKSawnok3XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10244
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Jul 2025 09:18:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19387

Hello Simon,

> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 07 July 2025 21:50
>=20
> Hi,
>=20
> It seems that openblocks-iot-vx2-02 has not been hardware reset and
> continues to work.
> Therefore, if the test is run on openblocks-iot-vx2-02, it will always
> fail.
>=20
> https://lava.ciplatform.org/scheduler/job/1288792
>=20

Please could you take a look at the openblocks-iot-vx2-02 platform in your =
lab and kick it?
https://lava.ciplatform.org/scheduler/device/openblocks-iot-vx2-02

Thanks, Chris


> Chris, could you fix this ?
>=20
> Best regards,
>   Nobuhiro
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Pavel Machek via lists.cip-project.org
> > Sent: Monday, July 7, 2025 7:04 PM
> > To: Chris.Paterson2@renesas.com; cip-dev@lists.cip-project.org
> > Subject: [cip-dev] Testing -- plathome_obsvx2 has problems?
> >
> > Hi!
> >
> > I'm getting a lot of failures in -stable-rc testing... it looks like
> > plathome_obsvx2 is always failing. One example is here:
> >
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /pipelines/190
> > 4974561
> >
> > Newer pipelines just show it as "running".
> >
> > Is it okay to just ignore that config for now?
> >
> > Best regards,
> > 								Pavel
> > --
> > In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> > Office: Kirchenstr.5, D-82194 Groebenzell, Germany


