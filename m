Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83E5C369AB
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 05:20:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.5778.1744953653602833954
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Apr 2025 22:20:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 53I5Kp8K1097441; Fri, 18 Apr 2025 14:20:51 +0900
X-Iguazu-Qid: 2rWh5b6vGSaOFxnj4L
X-Iguazu-QSIG: v=2; s=0; t=1744953650; q=2rWh5b6vGSaOFxnj4L; m=tXidH5F2w31qmSNdgQyVTA4mjt7HHqwiaN7MXXq9Wz0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 53I5KnLZ1073148
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 14:20:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utDbLzHvn3ZBmu59uk3o61U5gLrjNY+RqbXbGNSS25g/k9tOqMZjY5yUnPyO007BfxoSO9CLCFa1Tv4sTDm+PA1QZAXGJf1f/CiICNGgz2cbnGAPEXKzqFMrVCTJLjBRZY6LWCvYgtBBe1wH8oXTqz6NoqJVOkcoZZA+H4GISZOgrgnqTXcH5rK1JLyCSjFtY9q+KpMcZXSr7AKv7nJicOlnfg6nVM4A4OPAtpumQxhtyGppW/0m4/8sBMLRT0aycB/rxZ017N+uVYz1zmmAk90t3JRDtEyFMWLsAuodvF/cGfK4Jc/a17K/3YY8x0CAq4fRJs07Ay3Zf9Yul6msuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt82vpCYS0PF7B75q9bwAx0X4eHW43GSJ0PlylV3yW8=;
 b=C4boJWRW314srE4UuzzQdTajqGTM9NZLbU25rJvIaU7E7DHk1xkSKwWkx95ryT7CuwKPvmlzWnJY7KBqLEyLecGHGpzGlI7H2WkMYubhWrjFJJ+kKyg8gzNt3k7g3OG+EaNZtWYKTKbyVa5aL3X1ezn4nOEbZ02H19CA4k5PfYthmZ8BhTIYXP03UEYxvl4/jPtW21GmOkpwFSJXvF/1VWdNjhP7P+0MG3D76n0R7qWKkkv5ZIqfXwIJe82v+kuG0xLRG9JP9DOOokJUrrawsVsXPkEjwVIJy+rUIxPZot4pvo2hXxBwwb40yZ5VGJkNtS4ySc91ZphRNeWo3KBOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core v4 2/2] IEC_template.yml: Update IEC
 layer tests revision
Thread-Topic: [cip-dev] [isar-cip-core v4 2/2] IEC_template.yml: Update IEC
 layer tests revision
Thread-Index: AQHbr2q0ZOh8sB9CrUSc3RmEHYx6W7On2MoAgABItoCAAMCu3g==
Date: Fri, 18 Apr 2025 05:20:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB14838EF80E946D2BCB02E8208C2BF2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
References: <20250417072708.2757909-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250417072708.2757909-2-Sai.Sathujoda@toshiba-tsip.com>
 <7fb7d0ce-f588-4d85-a01d-ea8678588aa3@siemens.com>
 <825618d2-d3f6-44f3-b1f0-625f7256dd38@siemens.com>
In-Reply-To: <825618d2-d3f6-44f3-b1f0-625f7256dd38@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|OSCPR01MB12948:EE_
x-ms-office365-filtering-correlation-id: 4415452e-eeb9-4891-2950-08dd7e38c44d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dWxUTzZ3aUhydVYxZGU3U0RmNFhkaDg2b3FDYnRObEJhVmxIQy9zakIx?=
 =?iso-2022-jp?B?dFg3bGdzUmRtUm53dlpIZUY0OXRJbkswZDFldjJkTDlRUjZpOVVZRVlO?=
 =?iso-2022-jp?B?azV6akVYSndjQ0VxVFpmQWY4ZTgyc2ZvT0lWbFdVT1BVaUw3QW8wYTJV?=
 =?iso-2022-jp?B?M0JTSHBhdXhBSmtGQkhZWjcwL3Q0cmxpekJhR3BORUJaTHRxMDVBREdT?=
 =?iso-2022-jp?B?cGVSWWp6VHNxRzdPbDJUTEF3Q01XNFlTVVFqb0ZiMHJmdm5PakNpczZQ?=
 =?iso-2022-jp?B?aTdOaWdRZGgrMXdVUldVWlAyY2RIeGQ1TWQ5c0tObEI5eXdVV01SQmxk?=
 =?iso-2022-jp?B?QVFWVjEvTWNVdTdWMDdodDhIeWdBdHA4ODhzMjluMFg1YTd0YkpGZ1d2?=
 =?iso-2022-jp?B?L2RWTURaUWpMRkNUSzN2RVA1N0dWSXBvYlRrYW5KWHZROGhZMmRqeTZn?=
 =?iso-2022-jp?B?bzVURy9LeFM3bVhFSkh5VjNzcldlak9ic3RuRUtaVGE1MjY3c2VKa0g5?=
 =?iso-2022-jp?B?cGNKcnFoNllvMjFla2E4RjZiYkxtSHhFTFZoNE9qa3NRQXpMV0ZYSGFR?=
 =?iso-2022-jp?B?SUh5dTllUCt4TDhta2c1NzZmNW5iNHIyTTN4MXlrQ0NteVJCakw0dGkr?=
 =?iso-2022-jp?B?WXFTMnNTekhsQm1zaVUyTGNCUmV1V0g0MGNoanl5dzBpbThsTzIyQlgz?=
 =?iso-2022-jp?B?ODhINzFOOHJGSTUyazAwQ3hIcUtUVWhUVXAvSVJqbW93SnVid1ZwYVhq?=
 =?iso-2022-jp?B?aEZMWWJlN2JCbjFySjI1ZkdpSHVFb0M4d1dEd3crWGo2b01QeG81N01t?=
 =?iso-2022-jp?B?a2lQM25EMURFWkxjcnVCNEk2VjZMOFZkZWdrL0hMRWNibU5YME9JSW1O?=
 =?iso-2022-jp?B?SDQ3NEJvK1dGdHphZ3hPeEpuOEd3UW9MeE1pUFVLYjZvNUVxZG5wNzJ6?=
 =?iso-2022-jp?B?cnZHb1RZZTBhSCs2cnJ1c1RZSE1PSmRVZXVLWWJ2QUo0YXRDNU5ScExi?=
 =?iso-2022-jp?B?OVpCR0E3anJXVmN2STJoKzZNTjdyQmdVVDV5Y1hLOEhjTHB0WVFFcEFV?=
 =?iso-2022-jp?B?czAvOUFqUU5DVmJKQzdQcWYzRGMzMDh5aVB1Z0xGa09WdWdVTkROL1ZF?=
 =?iso-2022-jp?B?ODBkbWNGSURDSlVWem9GU1dDZUZ5WXhDNWZETDJjNmRHbkxKUXUvV3Zl?=
 =?iso-2022-jp?B?aXNPNjQrb0tWLzgwTWJua1oxVFUzTk96anRtWjU3S1Ayc3hGZlNpSXAy?=
 =?iso-2022-jp?B?ZUdWS09oS0lxanMzTTdlaGJKdFZPTjVDemd1ZC84VGNFMDlxTnNaL2FH?=
 =?iso-2022-jp?B?NXZYVGFkYVZ6RjFFMzhnVjducHpvekVzUVpwelliNlVwdXdWNmNrK3dV?=
 =?iso-2022-jp?B?L1RuOGxqSkoyU2VvTERrZmxBV0JrNjB1NXdSS2JFYVB1MExOSXJCaHZO?=
 =?iso-2022-jp?B?VGtNK2RpN3RvUWppb1pTVzExSzVtZ05mbGc0NEdrN0FrUkU2QUo4K2hG?=
 =?iso-2022-jp?B?Tlg4bkI3ZnZNZkF0eE4wS0pldUJFcTBBQ0RuaXFvdkE1R2JoMi9ENGc2?=
 =?iso-2022-jp?B?OUR0cTFPVkk1WmdHV3Y4U2hxLy9oRWQrVmN5Ym4rMlozeTUwRU5OOTdx?=
 =?iso-2022-jp?B?cG1xYk8rK3B3SzdZZkdpUnJSQlNITW1hNVdRRWxLNEVZbmF0NzI1UW84?=
 =?iso-2022-jp?B?MVo4RVkwclozaUFobTRIYWZEVnlCdnBRQlVnM3E5TlpCaDlBMHVEeFMv?=
 =?iso-2022-jp?B?cmIxZ0F2cWhOaE5XMkxYQnN1bk1Hc3JMMzdXM0JDR2ZlVDdBZUVvYStN?=
 =?iso-2022-jp?B?TVBNVHlJRzYxalZmeHIrWnFEczlrR28wc0N1dGdXMnFWeHJsN0JUWldL?=
 =?iso-2022-jp?B?SVNOL2NoMHgwazlUU2lrZHNoSEtCNnh6M0IrUTBYd25aa1lzaHpVQUdV?=
 =?iso-2022-jp?B?OUVoZkFLdkdyaDEzYmZXNk9tOVVxS0E5MTl5U1JPcTJUYU4yZXVZNzJD?=
 =?iso-2022-jp?B?a0FRS1lIUnRTTk9ieGxoSmhpSy9tYSt0bmhPY2d2NGNuU2ZKUklZd3R2?=
 =?iso-2022-jp?B?dDFLYXU1eTNuaS9rZ3BGdUZNcnBwTVhScHpPZVJMcE5xNFZEU2ZseHZn?=
 =?iso-2022-jp?B?S2g=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OWZzTU5LR1ZvbEJZL01KclBQM2FkRmpOS2J2MjRsMzJxNHY4YWVBZFE4?=
 =?iso-2022-jp?B?STdVK2lkTnl2RFF1T3B2NUVNeGV3amdFTjZRdnY0V3RKZW9pVURhcnJx?=
 =?iso-2022-jp?B?NVB5dUYvWExYWDJwZlRWZmRQQkhVcXljbVBBa2dKdjZjK2FEaVBpak5X?=
 =?iso-2022-jp?B?ZHJQU1pQNUFSTWNSTjFPN3pPbmI2bGM1WXVKUHdaSlZvWE5vNGVycmVs?=
 =?iso-2022-jp?B?NFBMYUJmM0NzNU94MXlhUFRYOHQ4aTdoZ2VGUFRBeEQrOWUrZFk2ejhO?=
 =?iso-2022-jp?B?VThQcEVGMGpORGNSUnRlcjV6M0NuRElqNHE5aXBuakpNUjNuYStSRVVY?=
 =?iso-2022-jp?B?Q3hJZzVIZFFrSXl5ck5qUlJCWklxc0lsK3NqbTduS0pQUjFZQkU5Q1Ir?=
 =?iso-2022-jp?B?dEtoQ2VKMkRFcGVxZW0zWHRtSnM1cExMMU9aNFdibzVJdy9xamxnSzVV?=
 =?iso-2022-jp?B?dXdrL1ZodXVYRkNhYVk0eURlRzBURk4zWmM5UllsbERJZDV6cDZqOEdr?=
 =?iso-2022-jp?B?YVkzWjZJVnVUWjJtM1NsSDRyZlU4czJWQy9aSTNQT1psYzc2UTVrc0lE?=
 =?iso-2022-jp?B?S3RVeUEraXBBOUExZngyRnFwTHZRSDduRGdHaE9ZWW8rOEVlUWVhdTFs?=
 =?iso-2022-jp?B?b3E0azVzSEMyOXovbnBqR1d1SklRRGJTS0wwVWhVNzl1aktqazlrMEZO?=
 =?iso-2022-jp?B?TW5nTVJrenVYV2U4RjFqdjZ2YXZ2ZUJWNUpFTnVPbWQ0eFg1R1NJWDRu?=
 =?iso-2022-jp?B?cTgveHZWQ0p2SnVKcjk3RlczVWdHN1Y0MHBZeEYyZTBQMVNiY1JVQkJa?=
 =?iso-2022-jp?B?elJ2amlaMXpqNWttc0QwMFBwKzkrdml0aCtFRmpiNFNYQXhCV3FONlhD?=
 =?iso-2022-jp?B?Tnl2ZG5aR0VaUEhCM2N4SzVkT2hBdksrN0FldW9NV0FtL2pLMjBUWnJE?=
 =?iso-2022-jp?B?T2hkd3UxQnQ4Rms1TG9sUG4vdGw5QkVhWHlLbGdKNWg0c3BFbmd1REp0?=
 =?iso-2022-jp?B?MkFleDVqTUt4SUJkZHNacUl3YTAwUlRGelVFME5SVUJNOHlNZGJsTGJx?=
 =?iso-2022-jp?B?VkVvZEVRZ0lwSjdyeFdseDQ0WS9wQjE5NEFobnJuYWRuVER0OVZXNzRz?=
 =?iso-2022-jp?B?ajV5NGNSay93bjdhN2gxYVJPNmdaY3BIVU5Hd3hxWUR5MUtuV2pwMGRH?=
 =?iso-2022-jp?B?S2FsVy90SDh1ZW5yMENFUTFER3Y2UDJpMWJITitna25wejZtT092K1VN?=
 =?iso-2022-jp?B?dnoxNEdQWmpYaU9CZlpCZEJ1bFFIUnp2c1ZvQkx1S21QbDhDekc2K0dw?=
 =?iso-2022-jp?B?RFc3SmhPTTN1YTllcUorRG91YkprQUUrMDY3TmlHbHNmS1NVSGpUam1W?=
 =?iso-2022-jp?B?THpwRDFzVENOSjBLK1BxUTJRbENKOVZMeGV6RzluZ0UxVzE0ZnphaWNM?=
 =?iso-2022-jp?B?amxqM1RsR3d5bExzYk5PNmltYlpBWi8xSXU2SG9mU0Jaa3pWYWJoWEVY?=
 =?iso-2022-jp?B?YTJ1cDVBZ0ordkRURVRVK1ByVWxMSkJGL29TUHR3ODhQTzVOaXBGelcw?=
 =?iso-2022-jp?B?amdZNFFacnFZU0s0aVhLS1VRQVJCZUc1c0VtUHg0U2dnYWVtaTlSeXoy?=
 =?iso-2022-jp?B?bExzTWFIUlRpaldnT3RseWZCL2cxblBJbWxseWtsS2RJeG9KWVM1L3Iz?=
 =?iso-2022-jp?B?VmtPb3FiME5vWFB1VC9hQUExRjRrQUMxWlRGYWdlL1JkbzNCV3FoNnRG?=
 =?iso-2022-jp?B?TGRwdTQ1NmRXdDEwczlWT2Eyc09aRStOTUpaeUZsSnZiZUpwR2ZmNlpS?=
 =?iso-2022-jp?B?WHl5QnBIS0tvR0k3cDhuckV4SzNnaE4vd1FraEduUnVnZzluYTNrc1VP?=
 =?iso-2022-jp?B?UEZCK3V6WEtXZE84dWdicWRIUktvWEZzRDVNUndtcHFtVndKUW8rczlu?=
 =?iso-2022-jp?B?emJDVklNQU1vZlRDNkw3bXlTTkJ6WnJEVGYyUjYwZFI4ZEFtVHRxZHQ0?=
 =?iso-2022-jp?B?UThXdTlkSCtMTTk2YUlpcFl2Z3ZwdnB1dHBDMEo1VGNVMHFZRzR3b1BD?=
 =?iso-2022-jp?B?Z3JkYjU2emdVU2dWOFJ4VXJrLy9FZTBiTzhEVUVNcWpoYjVkMHdQRkNr?=
 =?iso-2022-jp?B?SHB4YzRKNVo3QU93UnkwaHljdmg4djBERHpUdkk0Nkp3TGZuQk1qMFpq?=
 =?iso-2022-jp?B?NzZucEVKYlZSbWtLMDJnT0Z2Y2p0Znh3U21TTGozSy83RVZFRUdXMDkx?=
 =?iso-2022-jp?B?ekh4R3paTDROZ3dvbm5UemRIS29nblNLUWRjQ1VqSWVDMktZSkdBc3Vw?=
 =?iso-2022-jp?B?WDRGbE9DMmtxZlpnc054VTFwQ3VwTCtET3c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB14838EF80E946D2BCB02E8208C2BF2OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4415452e-eeb9-4891-2950-08dd7e38c44d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 05:20:43.3081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4RWJsLY0oGhHDKmayMibU5GOdcHQ7RpQJN+Bh1ma9Q48CXxeU5hNjPL7z66C683TULh1edBUaDTAX887AYE52EsqkbyjnhktyvgKhJR2gfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12948
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Apr 2025 05:20:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18527

--_000_OSCPR01MB14838EF80E946D2BCB02E8208C2BF2OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

envsubst tool is replacing the value with null in case if it is not finding=
 the exported variable in that template file. That is why it was unable to =
pull the swupdate file from the dispatcher because lava_dispatcher_id and l=
ava_job_id are replaced with null. https://lava.ciplatform.org/scheduler/jo=
b/1264806/definition#defline74

So I made the following change to the envsubst command to handle this, http=
s://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/fb13471312e69094=
83addb78e0c7644997383e66#a2c400ca9e562e29e60bd9b5edf0e3aa068ce6dc_337_342

Now I can see those two variables are not replaced in the job definition, a=
nd I am sure the x86-uefi swupdate job will not fail now. But just now noti=
ced that there was problem with flashing the device https://lava.ciplatform=
.org/scheduler/job/1265073#L236. Can you please look into this issue ? Once=
 it has been resolved I will send patch to update the envsubst command.

Thanks and regards,
Sai Ashrith
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiemens.com@lists.=
cip-project.org>
Sent: Thursday, April 17, 2025 11:13 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsi=
p.com>; cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#=
T=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core v4 2/2] IEC_template.yml: Update IEC =
layer tests revision

On 17.04.25 15:22, Jan Kiszka wrote:
> On 17.04.25 09:27, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>
>> Major changes in this update:
>>
>> 1. Fixed instability of TC_CR2.7_1 (Concurrent session termination)
>> 2. Added TC_CR1.10_1 (Authenticator feedback)
>>
>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>> ---
>>  tests/templates/IEC_template.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_temp=
late.yml
>> index c8efe40..b93ed4b 100644
>> --- a/tests/templates/IEC_template.yml
>> +++ b/tests/templates/IEC_template.yml
>> @@ -64,7 +64,7 @@ actions:
>>       definitions:
>>       - repository: https://gitlab.com/cip-project/cip-testing/cip-secur=
ity-tests.git
>>         from: git
>> -       revision: 5dbc47f55d4a43449dcbde4363e5d23d6e96344f
>> +       revision: bb19990c2b29ea96eea309e54124c74ea3246f18
>>         path: iec-security-tests/Singlenode-TestDefinition.yaml
>>         name: Security-Testcases
>>
>
> Thanks, both applied.
>

CI fails now, please have a look:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/9757849360

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

--_000_OSCPR01MB14838EF80E946D2BCB02E8208C2BF2OSCPR01MB14838jp_
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
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Jan,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
envsubst tool is replacing the value with null in case if it is not finding=
 the exported variable in that template file. That is why it was unable to =
pull the swupdate file from the dispatcher because lava_dispatcher_id and l=
ava_job_id are replaced with null.
<a href=3D"https://lava.ciplatform.org/scheduler/job/1264806/definition#def=
line74" id=3D"LPlnk252672">
https://lava.ciplatform.org/scheduler/job/1264806/definition#defline74</a><=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
So I made the following change to the envsubst command to handle this, <a h=
ref=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/fb134=
71312e6909483addb78e0c7644997383e66#a2c400ca9e562e29e60bd9b5edf0e3aa068ce6d=
c_337_342" id=3D"LPlnk733039">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/fb13471312e6=
909483addb78e0c7644997383e66#a2c400ca9e562e29e60bd9b5edf0e3aa068ce6dc_337_3=
42</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Now I can see those two variables are not replaced in the job definition, a=
nd I am sure the x86-uefi swupdate job will not fail now. But just now noti=
ced that there was problem with flashing the device
<a href=3D"https://lava.ciplatform.org/scheduler/job/1265073#L236" id=3D"LP=
lnk147920">
https://lava.ciplatform.org/scheduler/job/1265073#L236</a>. Can you please =
look into this issue ? Once it has been resolved I will send patch to updat=
e the envsubst command.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Jan Kiszka via =
lists.cip-project.org &lt;jan.kiszka=3Dsiemens.com@lists.cip-project.org&gt=
;<br>
<b>Sent:</b> Thursday, April 17, 2025 11:13 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Sai.Sathujoda@t=
oshiba-tsip.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-pr=
oject.org&gt;<br>
<b>Cc:</b> dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;dinesh.kumar@t=
oshiba-tsip.com&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D=
#I#T#C!{#C#P#T=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;<br>
<b>Subject:</b> Re: [cip-dev] [isar-cip-core v4 2/2] IEC_template.yml: Upda=
te IEC layer tests revision</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 17.04.25 15:22, Jan Kiszka wrote:<br>
&gt; On 17.04.25 09:27, Sai.Sathujoda@toshiba-tsip.com wrote:<br>
&gt;&gt; From: sai ashrith sathujoda &lt;sai.sathujoda@toshiba-tsip.com&gt;=
<br>
&gt;&gt;<br>
&gt;&gt; Major changes in this update:<br>
&gt;&gt;<br>
&gt;&gt; 1. Fixed instability of TC_CR2.7_1 (Concurrent session termination=
)<br>
&gt;&gt; 2. Added TC_CR1.10_1 (Authenticator feedback)<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: sai ashrith sathujoda &lt;sai.sathujoda@toshiba-tsi=
p.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; tests/templates/IEC_template.yml | 2 +-<br>
&gt;&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/tests/templates/IEC_template.yml b/tests/templates/IE=
C_template.yml<br>
&gt;&gt; index c8efe40..b93ed4b 100644<br>
&gt;&gt; --- a/tests/templates/IEC_template.yml<br>
&gt;&gt; +++ b/tests/templates/IEC_template.yml<br>
&gt;&gt; @@ -64,7 +64,7 @@ actions:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; definitions:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - repository: <a href=3D"https=
://gitlab.com/cip-project/cip-testing/cip-security-tests.git">
https://gitlab.com/cip-project/cip-testing/cip-security-tests.git</a><br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from: git<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; revision: 5dbc47f55d4a43449d=
cbde4363e5d23d6e96344f<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; revision: bb19990c2b29ea96ee=
a309e54124c74ea3246f18<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path: iec-security=
-tests/Singlenode-TestDefinition.yaml<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name: Security-Tes=
tcases<br>
&gt;&gt;&nbsp; <br>
&gt; <br>
&gt; Thanks, both applied.<br>
&gt; <br>
<br>
CI fails now, please have a look:<br>
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/975=
7849360">https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/97578=
49360</a><br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</div>
</span></font></div>
</body>
</html>

--_000_OSCPR01MB14838EF80E946D2BCB02E8208C2BF2OSCPR01MB14838jp_--


