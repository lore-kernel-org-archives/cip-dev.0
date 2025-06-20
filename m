Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A2C7115B
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 03:11:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.1432.1750389067101522353
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 20:11:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=pML96zfR;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750389050;x=1751598650;bh=80c74+NF91FsITRrdwAgZ6appM4/vH9lER4fW0Q
	FYfs=;b=pML96zfRfx2dZKJsXvxIqdjLChzW7V91+b9rTH7Px+lx6s2gPE9HyB0XMHVaIAFTKD3nG
	wGYWf5x+Q3QUTEpZrZWzx9ylIGTSdNWvi77S+FYYAMLGT9GKYvsvoV4DZ/FEJuy38DgTqMcV3+b6O
	Ml972gFwFJX7TUNiFuLc346QVzTj1xXnZQzeUOvpv8J72Bei2/6ofxiFKAFKafqGJqerRe3/GVGJj
	YKiSnkxFnTBc1MsnJCIaDSUUtEj6SgMLdvabyTTFT+20edPYLkGYLsQch31Vl/lpq8X9eweQsWpgP
	fb5D+5kle8/K6pfYFtImx4/tJkFgRQsEb4WvoAso5g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55K3AngX528784; Fri, 20 Jun 2025 12:10:50 +0900
X-Iguazu-Qid: 2rWhSHZE7XZBfjhF4s
X-Iguazu-QSIG: v=2; s=0; t=1750389049; q=2rWhSHZE7XZBfjhF4s; m=LfBvDu5WS15smKW8+DzCetWKEmxVpFctjRdoSZTVkx8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 55K3AlK21409003
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 12:10:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaLO7CLOXKSwhCvFm5G3sAlkdWni2JDO4J511Yg9F/tXXOV9k+6LLelRbkVGfjtoMJYw8MoR8WNlLdvjr7UfwEzNBmCdhGCRsqDPzIgTvuxY0U78JzVkgEf95lekUKAVACJMVtwXeEHmFewBnpSDU3++FlDiTdiDUSDc+Rj5EmVl9wWyGiBrfMA44CJjqso61cTTT5qjIUBB2dAjM8zl63pJRrkec9BIrluGGDye8x6NtJ2oindqaaPMecSr7Jz/vaom2DwDsnXakL7vkG5p4IpsPOuGMbjUsCKK9GI5fORfSPla0j3AtcVnW8wdlMVkmrJ2LUsU7yC2d2hxSz/Aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80c74+NF91FsITRrdwAgZ6appM4/vH9lER4fW0QFYfs=;
 b=AevRZ7Dp4XxfzKugheNmqWTFZFyQhePyHHsMkSIoNlqRzic+/99lFRBdwOLZNQb+RSRJUJ1IvHHuXosZbSZ5cU9WnRsnTsUz0j0x37VgXVrWp+ecA52J2KHAgsEEaUfYCtCC+1mObQJT5u1T5LWzf2kfBBFhrBXK/4nF0L/ctPO8DXFQhYOh1PWN16nhrkMGd5LRI9IslrjwUmqfcodFR9k1643vD5qn/mY7mH6LgXSnVlKvOA/tz6/9ShoYn7r2M8TcKy0xvZ9CWNTxs56G971lWXxzyOGV0nRgRiAF472K/WNBmCpO0JCZDvKPnM/z6pO57XyBRVi6ukdT+yB7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <iwamatsu@gmail.com>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Testing 6.15, bbb target has problems?
Thread-Topic: [cip-dev] Testing 6.15, bbb target has problems?
Thread-Index: AQHb4PlpiJWMYrt7MkStkjmF6vbEl7QKf8GAgAC/3oA=
Date: Fri, 20 Jun 2025 03:10:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818F5B189840E46ABE6F827927CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <184A639C5862A401.23068@lists.cip-project.org>
 <aFPR0THrbjSZ5m8B@duo.ucw.cz>
 <CACe6DC5N2ZHbYrEsPp-3reo7uy+iZ1NYmAPEvhdnhUo8Sc=rpw@mail.gmail.com>
In-Reply-To: 
 <CACe6DC5N2ZHbYrEsPp-3reo7uy+iZ1NYmAPEvhdnhUo8Sc=rpw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8595:EE_
x-ms-office365-filtering-correlation-id: 1a1f010f-3813-4057-d7d1-08ddafa80c55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TkpPTkdwbHI5Nm1PWEFITndOR0JHOEthbUYvU0JzZjI3Wk5KTXZ4M2JmbmpY?=
 =?utf-8?B?bnlnZjc4YlZDYll3UWxCRUhVMSs0WVYzSHlzSTE4dXhyeEY2ZWVhUnZ0WG9n?=
 =?utf-8?B?d2JrQTVkQm9uNTUyaEhaNmdtaXRkY040amxTZk9lMkRZMmlvalYzWE5YUi9H?=
 =?utf-8?B?eDZub1hrQjJIbXRYOS9ESW1wbHl5OFJBai9jYzlkQXlSbUdVdDg3MVRRZDdz?=
 =?utf-8?B?dXRGVTlzQmt6bTNnMHd0b1lWQ0xmQVVEQkVzNWdYelFLZ3NhZlB5b0U0aFVG?=
 =?utf-8?B?THBxY0tZYlFBN01CUzFHeExiZ1ZuZUNjZ1E5WVZ4RFlScXh5akt3N2k5RFVF?=
 =?utf-8?B?cTRrbmlkZ0JEOGxVOHFsTGN3UEptOU5uaVNsQmMzQ2ZYakFvVi9TWHVYWjFH?=
 =?utf-8?B?WWsrZWVXWlNHdno4ODJUUW9RVkRTL3FhYVRiSFZWUC9kWFlacmd1SFRENzhj?=
 =?utf-8?B?YmFmbDdkRTNrZTQ2NmdyMlh5UUpDOWhYbkRIdnR3bTRkako4YnNhQU9XL244?=
 =?utf-8?B?QU13KytHQWFuNFowQ1lTaFN5TzZPekFHaWZrN1NGcU9URXlRaG9OU0ROMjRV?=
 =?utf-8?B?WXZPU2pRU25kQmhVSXJxWmRSSkFsZlRDK1ZabzFFcHk0SENQcWNMQU9rYytj?=
 =?utf-8?B?RUZoVHE2bUVINTlOZEd5cmx0OEJXcGh3eThqWk9BRmxtT1J0RklEbFJVNVdi?=
 =?utf-8?B?VmhITFBRTWp0VmUzUytnMWpCYTZCWFd1NWk0QTV3NmlSUDNmMGJBbkRNR1pY?=
 =?utf-8?B?Wnh2TGFRallQbWcxaHRaS0NHckFKV0hQb0xBNUhtZW43NTFEUzZYTFhkQXVj?=
 =?utf-8?B?NUN2SFpDVUFXR3VseTVaRVBOZHBOaWF5ZWVodTIwa3Njbk1sb1ozV1FJcWV6?=
 =?utf-8?B?d2lrT043N0locUJpRFlHb2xvbURsaFhQQkd2eHFPUW5TemVvbk5Ud1U2R3dz?=
 =?utf-8?B?VVFLem81c3VFNnZsMWRFbXliQ1paRUw5a2JIOHlHZ0VSbUZyeURtTmRFQlB6?=
 =?utf-8?B?bmVPR3BPZVJFQUlubmdWMEdYS3owN0Evczd6S2h6dXk2UW5FMG5ua2JWS21x?=
 =?utf-8?B?bGQ1bjdlS3g2a2RITXlHRDFCYkxXOWVBS0JQcEZFazJkR014SXJMSTUyY2Fl?=
 =?utf-8?B?bjVCV2FOUjcva0pMdGtsbUpEa2JHWllhRDZ6WTczSmNzZXJJTDRRVnRTTUdq?=
 =?utf-8?B?dmlSbVhDMzlzdHBPbXQ0MkFHY3dWdXJjR0NmV25QY0ZrQzdwYWpGaHJPSVdR?=
 =?utf-8?B?VzVzQitMTUdIS3M0Ui9leWdPdzZLbVJlOWR3ZVRkNzh4L2p1REFoRTQ0eGp1?=
 =?utf-8?B?MUlNYkZsQmFOQzhsZlRTQ0g4cUV1VHprRnlNZVdJS1p3am4rTGhuV0JFVmRU?=
 =?utf-8?B?NmpSN1htUDFoWFpQRWROdnZKVWF1YVQ2QlF3dFRWOTdPTXNKVlhSb3JMaDRG?=
 =?utf-8?B?QnphRDd0SXVrWXFxdndRU1pTd29qRXRKT3ZmWkROU213eFh3b2k1VDBveVhT?=
 =?utf-8?B?TjJSMFUvcXRqOXFXbkJQYk1hamkyazc4aDlucDE3cG42ZXZCVkh3aCt1NDZq?=
 =?utf-8?B?M2lhSFFmckcxYlJ4OTZKdUhyZ0R4aHNPeEhXY3lwTTJoTVdpc3dHN1Nyemlt?=
 =?utf-8?B?TkNwNjlwQnpJOXB6dnRwYnpUUTNFaHZFckhrWGF5cmFJR0NWQTRJa1dHVWFl?=
 =?utf-8?B?azFQQUtjOVVMVVEyN1o3SVBhZVIwUEZPZGlLMXREaG1ZdklBVTc3T2dHQm54?=
 =?utf-8?B?MmZpYzJla0FkWmRVbmJSUFRtUWhVUGFSRFcxeGxTY1E2cUd5Z2FtYmFPWDBS?=
 =?utf-8?B?NGdjMk9meVNhQ3F5bkc5cVEvSzlqNXNVdzBpd2xxTEZML1N3RlA0WlY0b1dG?=
 =?utf-8?B?RkN3UzNraVpNU21NWXVMcDNjL0d6NTQ5RnBCRHREeS8yNCtRRVpBcW9DYktD?=
 =?utf-8?Q?rzKLa5QTCrA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VDRKSTgzSFN6cXZkMnYyNmk4YnpNVy9GV0hwWTd2Mlp6YmJyWXpxeXRZKzRJ?=
 =?utf-8?B?WE5PTWFIZjlPOVhDc1plclVBaUlsRFdHQXJZZExmQzZtRUxqV1ZXMXJmOWlU?=
 =?utf-8?B?OGVxaVJvd0luSTZTK1F1YnRsVVlNS2Jrb3JJNG43OTZuaWRuLzFyZDdZdlk4?=
 =?utf-8?B?NTI2RlRXUkV6WU1WLzZtOC9YL0FhV3Z5a3FTUEtib1cxVzRIUkNSemhHb0Qr?=
 =?utf-8?B?SmtjWXJndS8yQUgzdXJYU3djREIzV2JCSDlCUlpiTFlXL2hmSTc4Nk90aU41?=
 =?utf-8?B?djBDcUxNSHRZUGM2akpKMTNVU3BiY0F0RXYwcHJqVGM2dHpoZVU4VVJGa0dP?=
 =?utf-8?B?S0RKWVBIVThlYjR4cGlHa2xDcnJSaVRvMTFiaWU2bkxmaCtPNzVhZUd6NWVL?=
 =?utf-8?B?c0tyMGlacldSRmlGWEl0VEQxazlYNVFaem9NcFhRVythNGROWFh0LzIrK016?=
 =?utf-8?B?SFdZcTdhZmJ6ZFNoWDdrdGJiQmZaaUh6cS9ZSmY2b3BGZ2UrR2w5WFZlbk12?=
 =?utf-8?B?eU9RTGNFMGtYRXZJUEhidDczeE5Mb21VRTJGTGcrWDJ2MzMvODdSdktrL2ZU?=
 =?utf-8?B?S0kyWGtiNEdEd3B3bFZmZ1VjQ1ZDaDZFdFhyTjk3SGZoZzVvL0xWT2FmT1B5?=
 =?utf-8?B?ZXlsRCt1UHB6MzMyOTVxeTZiek1Za05jc1Z2ak5qdUg1ZGFDdUk0dXMxT0RC?=
 =?utf-8?B?amdYc2Z5cWlGRkFEMjFoSmJHNkIwcHJGTE9uVDdGMnBuTWUra3U4aDBVSEF5?=
 =?utf-8?B?Um8rVkVQQnNmQnNYZUtuNDhDN1NoM0N6Y0pHcUlUWWt5ZThvNjJ6M255YStO?=
 =?utf-8?B?anFQUHpzVlJvTHQ3MW9SU0N1bDlnOCt5RzBkYTZuU3U4bzlNUlN4UUU0d3JR?=
 =?utf-8?B?MWdMWHZ6SnhIWFJxd1NvSm53QlkyNVg2akZSbnBBbU5BUjNWYW1NK2Nqelo4?=
 =?utf-8?B?Q29mRnluTUdtWko2Kyt4SHZmUlZrc2VtWTJRLzI5OUNnSnp0bHY4UnZPa0FF?=
 =?utf-8?B?amVuSTRpVkNqYlY0OEorVWJBQUdWem9HZzN6eGdEYmlsYXdNQk5CYWJkTjh0?=
 =?utf-8?B?OC93dlpEVXVGTzN6blFYZ2NFNEEwUXJRWm9xSUdNSlVtS0I3NHhCS0x4TkZF?=
 =?utf-8?B?TEtRQzV5TFdFTUttZmhuMGExV2tqcFBGMVl1ZUhmdktPODRBTEN3alAwZ3Ru?=
 =?utf-8?B?Vk1mZm5ZRGdsVEtyWW1uQVM1VCtsSVg5WkppRy8weGY3WGswU0cvd1Q4Ym9n?=
 =?utf-8?B?MWgxbURvRHl0NXhGRTR4dTkrY3ZSTlB3K055ZjQwVW92U2szblEvVlducDVv?=
 =?utf-8?B?anMrU0dKdDZoZmFuZ29aN1ZPR2t0MVY4R3lEV1ErcFdMdm5sWm5lR3lwRmUr?=
 =?utf-8?B?VTZoOEtvczJaZ2JvRWlLUXd6UlY2cGljQmpVQy8zY3BCTmFReGJOMC9uU0wy?=
 =?utf-8?B?K2JyaEE3Z2ZBUWF1dXk0djhUaDkzK0hJdzdieTM5U1Y0M3JjV2RodEd2YjFM?=
 =?utf-8?B?dG44Q3pJU3pMYjkzbHFvcEFEdTcrMm5jZ3Z1clVOQ2d4WGpUcE5GVnkySWdC?=
 =?utf-8?B?cStsUk94MjhwVVBDUVZnVUtKY0dGVkJaSFFMZWwwVXRpbHRPWTNBd3p1TzVL?=
 =?utf-8?B?R0dnSDJVN1JyMW56aFJFOGlOM2hXSGxoYnVTNlM2U1d5NUNveUkrZ0d1emMy?=
 =?utf-8?B?aTdldG16SDAzNUFoK1RKTTR6bWpEVFZJTEVHWVZiSzJPamxsL3YzdEtoYVRz?=
 =?utf-8?B?TkwyZktRVGtGNlVJa2RsMGlLazU3RVQxaGFSMkFtWEdNcklMbXBhTkdjN1pH?=
 =?utf-8?B?c1BLTWFQWlIwek53bXcxM0lmN3piYjR6N2hJd1ZOU1VEY2NONVhFWWU1NDFB?=
 =?utf-8?B?VzVVQVVuZUVOOUN6bWxjMzRrYnROQndtZHVvM0pPUDNRN0JyQjl4cnB6UWtK?=
 =?utf-8?B?UFcxNzA2aGZCM3ZlZlhlcFI5ZE5HM1ZSVXlKYTVQYzlWZUZvcmk0bmQxZG9K?=
 =?utf-8?B?K0kvZWkzV056cFBmNGdqek1jRnN2cjVudkVPMHBYa0FLUWxjWU5PcUhwN0xS?=
 =?utf-8?B?MjNLdjFCbjhtWTBrK213Y0l0b0FvWllnUnhBM3hxZUdLeHAzbmxPM1hvY25p?=
 =?utf-8?B?MkNOUlNiYTNvaWk4TnpSUzFZSW01ejkwTUJvRHIrZGZGVzVadGZiRkNtZlJ3?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1f010f-3813-4057-d7d1-08ddafa80c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 03:10:45.2306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyH+NQLBqQkYx0/HHtUVCc9Lh/8egEh3NO9Clo6OHOena8kUfPNA0qFlXlfsN54Gf8JuFMlIN8yq/DU1rPa01E9kp4CvLclIO9brPiWrvJ+lS08ces0BOYqmbqUVXGQd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 03:11:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19146

SGkgYWxsLA0KDQpJIGhhdmUgYXBwbGllZCB0aGUgcGF0Y2hlcyBhbmQgdGVzdGVkIHRoZW0uIFRo
ZSBwcm9ibGVtIHNlZW1zIHRvIGJlIGZpeGVkLg0KDQo1LjQueToNCiAgaHR0cHM6Ly9sYXZhLmNp
cGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTI4MzYyOA0KICBodHRwczovL2xhdmEuY2lwbGF0
Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMjgzNjQ5DQogIGh0dHBzOi8vbGF2YS5jaXBsYXRmb3Jt
Lm9yZy9zY2hlZHVsZXIvam9iLzEyODM2NDgNCiAgaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3Jn
L3NjaGVkdWxlci9qb2IvMTI4MzYyOQ0KICBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2No
ZWR1bGVyL2pvYi8xMjgzNjUwIC8gTkcgKGxhYi1jaXAtc2llbWVucy1wcmFnJ3MgQkJCKQ0KNi4x
Lnk6DQogIGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzEyODM2NjEN
CiAgaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTI4MzY2MA0KICBo
dHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMjgzNjU4DQogIGh0dHBz
Oi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzEyODM2NjIgLyBORyAobGFiLWNp
cC1zaWVtZW5zLXByYWcncyBCQkIpDQo2LjYueToNCiAgaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0u
b3JnL3NjaGVkdWxlci9qb2IvMTI4MzY1Nw0KICBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcv
c2NoZWR1bGVyL2pvYi8xMjgzNjU2DQogIGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hl
ZHVsZXIvam9iLzEyODM2NTUNCiAgaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxl
ci9qb2IvMTI4MzYwMCAvIE5HIChsYWItY2lwLXNpZW1lbnMtcHJhZydzIEJCQikNCg0KSSBoYXZl
IHN1Ym1pdHRlZCB0aGVzZSBwYXRjaGVzIHRvIHN0YWJsZS4NCkhvd2V2ZXIsIHRoZSBwcm9ibGVt
IHN0aWxsIG9jY3VycyB3aXRoIEJCQiBhdCBsYWItY2lwLXNpZW1lbnMtcHJhZw0KSSB0aGluayB0
aGVyZSBpcyBhIHByb2JsZW0gd2l0aCB0aGUgTkZTIGNvbmZpZ3VyYXRpb24gZm9yIGJvb3QgcGFy
YW1hdGVyLg0KICBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2RldmljZS9i
ZWFnbGVib25lDQoNCmh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzEy
ODM2MDANCiAgaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTI4MzYw
MCNMNTY3DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uDQo+IEJlaGFsZiBPZiBOb2J1aGlybyBJd2FtYXRz
dSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDE5LCAy
MDI1IDEwOjQ5IFBNDQo+IFRvOiBwYXZlbEBkZW54LmRlDQo+IENjOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFRlc3RpbmcgNi4xNSwgYmJi
IHRhcmdldCBoYXMgcHJvYmxlbXM/DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBJJ3ZlIGxvb2tlZCBp
bnRvIHRoaXMgaXNzdWUgYSBiaXQuDQo+IEl0IGFwcGVhcnMgdGhhdCB0aGlzIGlzc3VlIGhhcyBi
ZWVuIGZpeGVkIHVwc3RyZWFtDQo+ICg5MjlkODQ5MGY4NzkwMTY0ZjVmNjM2NzFjMWM1OGQ2YzUw
NDExY2IyKS4NCj4gVGhlIHBhdGNoIGhhcyBub3QgYmVlbiBiYWNrcG9ydGVkIHRvIDYuMS55IG9y
IDYuNi55LCB3aGVyZSB0aGUgaXNzdWUgZXhpc3RzLg0KPiBJIHdpbGwgYXBwbHkgdGhpcyBwYXRj
aCBhbmQgdGVzdCBpdC4NCj4gDQo+ICAtIDkyOWQ4NDkwZjg3OTAxNjRmNWY2MzY3MWMxYzU4ZDZj
NTA0MTFjYjINCj4gIC0gYjliZjU2MTI2MTBhYTdlMzhkNThmZWUxNmY0ODk4MTRkYjI1MWMwMQ0K
PiAgLSA2MjNjZWY2NTI3Njg4NjBiZDVmMjA1ZmI3Yjc0MWJlMjc4NTg1ZmJhDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+ICAgIE5vYnVoaXJvDQo+IA0KPiAyMDI15bm0NuaciDE55pelKOacqCkgMTg6
MDEgUGF2ZWwgTWFjaGVrIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPHBhdmVsPWRlbngu
ZGVAbGlzdHMuY2lwLXByb2plY3Qub3JnPjoNCj4gDQo+ID4NCj4gPiBIaSENCj4gPiA+DQo+ID4g
PiA2LjE1LlggaXMgb3V0LCBpdCB3b3VsZCBiZSBuaWNlIHRvIHN0YXJ0IHRlc3RpbmcgaXQuDQo+
ID4gPg0KPiA+ID4gUGx1cywgSSBzZWUgYmJiIGZhaWx1cmVzIHdheSB0b28gb2Z0ZW4uIEFueSBp
ZGVhIHdoYXQgaXMgZ29pbmcgb24NCj4gPiA+IHRoZXJlIG9yIGhvdyB0byBkZWJ1ZyB0aGF0Og0K
PiA+ID4NCj4gPiA+IE9uZSBleGFtcGxlIGlzIGhlcmU6DQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly9n
aXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5nL2xpbnV4LXN0YWJsZS1yYy1jaS8tL3Bp
cGUNCj4gPiA+IGxpbmVzLzE4NzQ3NDc1MzYNCj4gPiA+IGh0dHBzOi8vbGF2YS5jaXBsYXRmb3Jt
Lm9yZy9zY2hlZHVsZXIvam9iLzEyODI4MjENCj4gPiA+DQo+ID4gPg0KPiA+ID4gWyAgICAzLjU1
NjU0NV0gU2VuZGluZyBESENQIHJlcXVlc3RzIC4NCj4gPiA+IFsgICAgMy41NjczNDBdIG1tYzA6
IG5ldyBoaWdoIHNwZWVkIFNESEMgY2FyZCBhdCBhZGRyZXNzIDAwMDcNCj4gPiA+IFsgICAgMy41
Nzk4ODRdIG1tY2JsazA6IG1tYzA6MDAwNyBTRDRHQiAzLjcxIEdpQg0KPiA+ID4gWyAgICAzLjU5
MDQ1Ml0gIG1tY2JsazA6IHAxDQo+ID4gPiBbICAgIDMuNjAwOTgyXSBtbWMxOiBuZXcgaGlnaCBz
cGVlZCBNTUMgY2FyZCBhdCBhZGRyZXNzIDAwMDENCj4gPiA+IFsgICAgMy42MDczOTVdIG1tY2Js
azE6IG1tYzE6MDAwMSBNTUMwMkcgMS43OSBHaUINCj4gPiA+IFsgICAgMy42MTUzODhdIG1tY2Js
azFib290MDogbW1jMTowMDAxIE1NQzAyRyAxLjAwIE1pQg0KPiA+ID4gWyAgICAzLjYyMjE5OV0g
bW1jYmxrMWJvb3QxOiBtbWMxOjAwMDEgTU1DMDJHIDEuMDAgTWlCDQo+ID4gPiBbICAgIDMuNjI4
NjcwXSBtbWNibGsxcnBtYjogbW1jMTowMDAxIE1NQzAyRyAxMjggS2lCLCBjaGFyZGV2DQo+ICgy
MzY6MCkNCj4gPiA+IFsgICAgNi4xMzYzODJdIC4uLi4uIHRpbWVkIG91dCENCj4gPiA+IFsgICA4
Ni41MjM5NTBdIElQLUNvbmZpZzogUmV0cnlpbmcgZm9yZXZlciAoTkZTIHJvb3QpLi4uDQo+ID4g
PiBbICAgODYuNTI5MzI3XSBjcHN3LXN3aXRjaCA0YTEwMDAwMC5zd2l0Y2g6IHN0YXJ0aW5nIG5k
ZXYuIG1vZGU6DQo+ID4gPiBkdWFsX21hYw0KPiA+ID4NCj4gPiA+IHNlZW1zIGxpa2UgYSBuZXR3
b3JrIHByb2JsZW0uDQo+ID4NCj4gPiBBbm90aGVyIGV4YW1wbGUgaXMgaGVyZToNCj4gPg0KPiA+
IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1zdGFibGUt
cmMtY2kvLS9waXBlbGkNCj4gPiBuZXMvMTg3NTAxOTgyMw0KPiA+DQo+ID4gSSBjYW4gcmV0cnks
IGJ1dCBpdCBjYW4gdGFrZSBtb3JlIHRoYW4gb25lIHJldHJ5IHRvIGdldCBpdCB0byBwYXNzLg0K
PiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQYXZlbA0KPiA+IC0tDQo+ID4gREVO
WCBTb2Z0d2FyZSBFbmdpbmVlcmluZyBHbWJILCAgICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6IEVy
aWthIFVudGVyDQo+ID4gSFJCIDE2NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hlbnN0ci41LCBE
LTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo+ID4NCj4gPg0KPiA+DQo+IA0KPiANCj4gLS0N
Cj4gTm9idWhpcm8gSXdhbWF0c3UNCg==


