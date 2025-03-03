Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072E7C282C5
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 09:20:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.49562.1740993612666449651
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 01:20:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=JrDP4TN0;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1740993600;x=1742203200;bh=u9AQk7VgaQSbHVoo2k2mnIvzhtJOQRypOqRfS38
	/8HQ=;b=JrDP4TN09QoZiONbRkncuMKX/95cy38yxGuOt3u7kAIjgUhqi6g0C56XpOVQmW7/wN00G
	Fq6oI5OGPIi2/jijdfHsFMave7/yC5ZoD3/766TIJYnHy/HSB9Jb35aY5/fAGOzMaFFJtFXMNsFIz
	Ucb3XFE7hhjZ7ATkmLKk+fGmJew4P27hkcUiTbMG0uMAn+FT2dePvPKrqS5jQ31/UqMOYgtH9B1vm
	8meyVKaHxGqJq3wo2RluYyqOlew8NZ2jic8/GETD92q0XFYul7FfgjovxwWMFWKJQbNq47uDkDEGH
	VjAqBR9Aede6deUWhLx6cZCOBGbPDjO9YFySXn7Ocg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5239JxFD1393068; Mon, 3 Mar 2025 18:20:00 +0900
X-Iguazu-Qid: 2yAbJ3LJ2WGAVUKeV0
X-Iguazu-QSIG: v=2; s=0; t=1740993599; q=2yAbJ3LJ2WGAVUKeV0; m=fXpu5nvmnI/e3CYgWhcB/XQk3m2SKNgy3mtX/gZrpHI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 5239JwkQ192517
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 18:19:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWf1EcpgGaSnpnl+TwvdqLUVjojZTQenM2/zQgHoQCBfhQgeD6NWmk/ACLT5jnvgccI4PvfdfAf5O3Br0aF3uvwlpMUH3iaMSPTegH2kOw/vaxvJAccvjh1rJyFwqxqj46Rj9vqv90CjulYTffgQdLqD0NB+xO275BNHgHa4FCfVIvZXiU/q8K1VymD2qPuMLu25bRrvOuQqaW7pVNoXryCjYXtKTA3oAFnYpUyEr84Tw8OHoDvo9xHOyUe60K5iH91Z+6jjYgM+QIS6WWU5kjjFCTyuft/sQ9ITrVD/x0Yr/hEpq73ewSauDEZvCLUtqk7e3tMtXEIPJwexwNnLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srONc9qV7x19CL82JdSaoQbNBVLMyW7qTnrZpRjQuZ4=;
 b=jdiOd5QWagQOUeWN+WH28EbH08B9rOccj9cUJB4EiJ8YvNuyfMBrXEeavttBHVEl1HNuL2YUTBVpjKDyaQUWUZ2/Wz4AFd8zVcqzVAsqGYjJf7QrSfYCEIHQHL08TLw6SqDRd+D14NhCjAJT+9aZjb5YbSS6/O1//AkCmW/jvH3TfTRpH/hmnVU39XBbuPCIS1IBVL/PgwAJtehybSi9c6I/ap8vPxNRTDE45Ldnk8l4PuPW1Rr4T+tA2ZGBouIFXw0r/vPwXlzTP0fiyRvaH9b0yBZ29OsS0FQIml2GJ+Jphpw3kG/ikGJYBXDDKtY79ADDcof2iAqMK0Z3POtJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <paul.barker.ct@bp.renesas.com>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip 00/12] ravb backports: MTU fix, VLAN & IPv6
 support
Thread-Topic: [PATCH 6.1.y-cip 00/12] ravb backports: MTU fix, VLAN & IPv6
 support
Thread-Index: AQHbiS0Z2h/A+7axdUaS0103PzcyMrNhJ6tg
Date: Mon, 3 Mar 2025 09:19:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818285CED4A08E1A8690D2092C92@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY1PR01MB10784:EE_
x-ms-office365-filtering-correlation-id: 74e72c22-77f1-4bf6-9513-08dd5a34906e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QnNaZkdPVWZ6alQ5VDJoaTI0bFNBdFhuYVhZT2NOanNTWFFrdDVsekRP?=
 =?iso-2022-jp?B?dTR4ZFVjdGhrQnlOK3pJY2VtNEkxWXpacHVkTDJrYU9RdGszRmhYY3RL?=
 =?iso-2022-jp?B?WDlocWtEZXpRSmxvR1E3TllkVEVFNVJoQzJRTjExZUdqSk9YYkFFQU0w?=
 =?iso-2022-jp?B?eVF1d3pGNlFBVGpaM0txZ0lkMmFoZUdlaWRsTjRWbld0RjE5b2VYYlhP?=
 =?iso-2022-jp?B?N3g0OXgrTmRUT2ROM1BzZHkrNDRFWVhRMnE3Z3Bqamp5Z0cvWWZ1WHc3?=
 =?iso-2022-jp?B?WnlpMTNMdWlKR1dvdUdJRFA4dXgwSVpyYWtWY0o1VlZvVGQ3Z3F5aWEy?=
 =?iso-2022-jp?B?TXE3QmFQcHFlTm9KaXhxZmlzaDg4Zmx6TzdTQjd2YVVtSWRydGRDZU1S?=
 =?iso-2022-jp?B?N3kvYi8wWGdnV1B5N29Jdms5QkNRWWgxTmdZd0xiekxibUtYZm8rWXBp?=
 =?iso-2022-jp?B?cUoyQk1jWElFV0p6YzN2RmxVbHFib0Z6MHhrVXlnWVdLZGVqdXhCdzhF?=
 =?iso-2022-jp?B?RTM3MkNuc3dKMHlEQ1lTWUlERi9WazZEUktmVFgvWCtNRVFPTkg1R1pw?=
 =?iso-2022-jp?B?U2hBcGphK0psb3M4Uit5TTA4Ylh1Z0c4aEdhNEQ1TmZoalI5R3JDSnhZ?=
 =?iso-2022-jp?B?Zm9zdU55K2U2N2NoOURuaHpzNFVyNG1oVmx2TlZ5ZVhVOXNzNXBRTEow?=
 =?iso-2022-jp?B?VTV0SnlDNFNtZndZOHdQWlB4ZnBDT0J1YlQwNW43ZitRVkhUUFFYbktD?=
 =?iso-2022-jp?B?WEwxS1hVME1iN1h5SURBYUpCMVFibHp5dXpzZUx4V2h0eGJVb3JLSzRX?=
 =?iso-2022-jp?B?T2xQSmc5MStsMjR1bmxSZVAzNkRUbHZ4TitNU2t3UmRRSjRIOWdnWDA3?=
 =?iso-2022-jp?B?NVJzV3AvQ2NWZ2hPZnR1SzlReFV1b2h4dXFqOFNiUzhaQXE5STdSbkRZ?=
 =?iso-2022-jp?B?RlhvSUxOSElmeFBIelE5OFNWZkx2bG8zNG1RcjZaSmJsMXZROE5URk5l?=
 =?iso-2022-jp?B?SDRGK0Rqc1BIeWc2OW5nakhrajRQc0FvdHFHZXlKdVAvQlA2NXpoM2Zt?=
 =?iso-2022-jp?B?S0ZqOFVvVlBESFFWQW0xaHM5TlBsNXVsWUJ2cEY3VVMyaWtDUDVUdDgv?=
 =?iso-2022-jp?B?RklWUFBKN1dPYjIxcUZYb0kvWHNkZkZSYzFaSVpOT0dRQVppM1l4N01r?=
 =?iso-2022-jp?B?eVgwdEtKVlFUZHRVcE5meXpZa212aVA4YUhZWHUzaWxTSnFrbFFqUldX?=
 =?iso-2022-jp?B?b2lNeEhyWGQyZmdWSDc1eHFZSExLeWdGeEUyNlJpT2tkaHNmNWhqUEd6?=
 =?iso-2022-jp?B?YjN2dW55bndEYnh4RExTMktrU3UzMGVHR1V1dWtkU2lpUlZHM0hRY1JN?=
 =?iso-2022-jp?B?NVptMkFIZjBTWW5iMEZveVR4emlORXhGTGtiaUIyN2dwUVhpNmZCYlNP?=
 =?iso-2022-jp?B?dnBJS3BmRWpxK1dxSXNCelN5S3BnZHIveDJ4bzdnVENOVHpBY1lVTHhR?=
 =?iso-2022-jp?B?TXJsOTVsai9odGdYVXRQMTdtemhFcm8xSHFva3lKRDRkVXFMY1owU29H?=
 =?iso-2022-jp?B?OXUwZ0kxSnRXTE8vM1RPa1ovdVE2d3ozNGFYL0l3b2Nramo2Z1FmdXpT?=
 =?iso-2022-jp?B?QlZCckdGbVVyRGw0SzZiRjcybTdob3V6NFRyY0pVZ1pmaWNKL2plajVM?=
 =?iso-2022-jp?B?RDVjblJVcml3UVpHdm5MQ3g3QXBwelBFQnYwaDZ6ZENxS1JhdFZ6RTNF?=
 =?iso-2022-jp?B?SjFCUzdQQmtTVkZBcDBxd3BvWmJXWkxmYWdTMGZRcHFqRlUzOHVQdEoy?=
 =?iso-2022-jp?B?cUFuK2JsWHc0MzhmSG4xZGRJOVZlNURBdkEyZVQ4eXpPL2xaeUpHSkty?=
 =?iso-2022-jp?B?ZGtmdUoyTGtXZHJkejFEdkozeTdvandDZ05ZZGZ6QmhMQ3Y4V25HMU83?=
 =?iso-2022-jp?B?SEJqYWtROXdTQlA3MkZHSUdISHZsOUlkVG1iRGx6MDZSTXJFb2llUm4z?=
 =?iso-2022-jp?B?VThlQ3JhMUc3UmZlRGt6SzRzbnVyRlRVNVVvazNhVFU5b3dHK0ZodmQr?=
 =?iso-2022-jp?B?RUdwNUlRMHN4MWRlZ1BCT3dtZ2VxamI2WTQrME8rOFk2RHpMNlNtQjU3?=
 =?iso-2022-jp?B?YllUbEo5SllSOEdIMmtZZTZvc05FT3ZYVDJ4aGF5aEFFemdkT3lkY1Na?=
 =?iso-2022-jp?B?bklRPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bUQ2Y3ZwSzByZXhLZTcxVDNmWG9hMG1ENnJTVFJ3WjVoMlM0SHczSGJZ?=
 =?iso-2022-jp?B?UnQ1cWFIVC96cHprRE5YQjQxK1dXOGJYSndxT2xraDhFaEFmSjFXc0tq?=
 =?iso-2022-jp?B?SDUzZUhRbFdtSzFpalo1bHlaTnV2L0pqWTFFYkZRUCtrdnY4Ym9YR0xK?=
 =?iso-2022-jp?B?M2JHUmxMT1R1VzB5M0xFdVpOYytNWnRLOVcyaTg0emdLejlITUh0eEVa?=
 =?iso-2022-jp?B?UjJHMGwxdkhDNU9haHR6cnRzd2kvUWhmeFRBTy9kZWRpN2R3UEZhb2xM?=
 =?iso-2022-jp?B?em1xdEo2UTVhdzhxSVEvZzJLK3NnakFIK0kvRnVOclFQbkJ1RUpqNnZU?=
 =?iso-2022-jp?B?dk9xb1crV1BtKzc5dnFSUTBlbWpvSTkvV24va1BCa1l5dHBoelpGVUlJ?=
 =?iso-2022-jp?B?Q3pxMlRqK213RDFQRFJyc2U3aEk3TlMvcHVoQVp4c3VLT2IvMEhJTFV5?=
 =?iso-2022-jp?B?S0IzUUIzQ29kZGpiczJnK0FwSDFZVUtZWXVleVR1SlBrVS9XTnBlY0RB?=
 =?iso-2022-jp?B?ZDFtMVJHdFhoSmtwaXZxNStabkpxSU44Vk45TDNxLzF3K0Ird3pmU1NJ?=
 =?iso-2022-jp?B?TmVoa2tONDVzQk5ock1FSmpIdEJVZE5TQ2o4QzErSnVBeDNZMFlvUDdz?=
 =?iso-2022-jp?B?aldycisxL0VRRlVDaGY5d1pML1B2eHQxd1g3a3BuTXczUGxydGFxRkNI?=
 =?iso-2022-jp?B?d21JY1UyZk1RSDkrVXB3RS94Y2NHYm1BQVJoWFkrM3dBZTlOYW9yVng5?=
 =?iso-2022-jp?B?SGExVU1oV0owa0JTL2pQU0x1RjVCZTdOSWt1RzJkMDZSNzZvZzhJVDJi?=
 =?iso-2022-jp?B?VzE3bUxDbCtVRG1vYjZnblBUdmUrR1pSSjY0d3U3YnR4RkZOWmlyOXEy?=
 =?iso-2022-jp?B?Qkw4ajlKVHVmeW44bGw1TU1lMEFycUFlVmZTaXVGcSswVEo0SnpWRGFZ?=
 =?iso-2022-jp?B?T2pxQWs3MitNUDBXVUx5ZlRIT3I0cVdtVExVZmVEV0FBQWdpdGltQm1z?=
 =?iso-2022-jp?B?Z2xOR2lIRzFOeGJ1YTVmSmVEbHdSZ1NxeDZXb0luVU5OUVVjSEh1aHJk?=
 =?iso-2022-jp?B?SnQyTjJOSVF0WFpqaE9pcXY3QlJwUHN2K2ZGNU9hRkVWU0NoSllVeksr?=
 =?iso-2022-jp?B?M05uNEp4MjlsRWRaZHRDSmRMNko5UlpGdDI3QjRrZXNoMktESmxtU01D?=
 =?iso-2022-jp?B?Z2xTQVBZNVYwMWVVa0h5RGFISnhlb1dTZGZRWWh0aVhNMTFQWGRBSDVP?=
 =?iso-2022-jp?B?VGprMlJmeUEzZkxzaGxQL0FTdi9Xbm15UWdpOGJDR3FqSlI3bGtxOVNp?=
 =?iso-2022-jp?B?QVRIWXMrdzlickZObjJFaktIQWdqV3dwYU5lVzVLd0NMaXAxNndQQmVs?=
 =?iso-2022-jp?B?eEN0R2RmZnptdHpBM01xZ3Z1M291eTkwV1JPTE9UYXNlYnlrbFF4cFBz?=
 =?iso-2022-jp?B?WHNhNDZQeTk4Q1IyOWREbVlHbEpwaFQzQUh1NnZCOUd1NTR0VE1wK0cw?=
 =?iso-2022-jp?B?MFh2eXFQcGVqVHRvSHJyRENqU0d6bkx3N294VE4xeWJGaTVOZzR5OFNX?=
 =?iso-2022-jp?B?Ni9PUEJKb2k1dGNUQmhaTEZLRVZHRVZURjJVYi90Nmw1TUdoRy94TEVv?=
 =?iso-2022-jp?B?dmVKejFZTE1yRDVpeHRJV1lRREI2bGdVM1UwcG9xTTh5WUhpdGgyOTRY?=
 =?iso-2022-jp?B?ZGc3VXgwYmtGUFVtMHFnelJoUnd4K1BQRHZlOWZvcm9qRHZuajdpK0c5?=
 =?iso-2022-jp?B?UjhibHIrU0sxMVpOMmFNeEFtV2pKaWtTWVlaa05SVUlQRWo5YXJxZzhL?=
 =?iso-2022-jp?B?TEd3eWxjZDNhVGoxTzNZcDN4N0FHT3NteCs0VStMTWhRdVFWMWJHc2xC?=
 =?iso-2022-jp?B?NDdXNHVDK3ZCeGwxTVhrN1dtZTBEU05GU254MnN2VUR3d3puZ0R3MldN?=
 =?iso-2022-jp?B?emg0S0MrZDlmWW1uK1FWTDFBdzh1a1Z5eDZwRE42T0FPVnozeE8vT1po?=
 =?iso-2022-jp?B?U2pRMkFjRmVNN3M3azNBc3dFYUJqODFVeDcxcERtY0x4azZYWERQeHJz?=
 =?iso-2022-jp?B?K0xZUGhFajBzaWhhTEVaTUsycnZUR0hLTmNZYXJxMmhEYndpNGc0QTFM?=
 =?iso-2022-jp?B?amsvcklkOEVyK2RoLy9uVFUxY3hOSmU0RmlZb3I0dVRTRng3Y1JiaEo2?=
 =?iso-2022-jp?B?VnFYQW1MY1dLZkRST3B5Qm52ZHAwa1liSTZiK3JRL0prR2dRSVRjb0tR?=
 =?iso-2022-jp?B?RzBDRnYydkhmeFcwSHQ0SDhpM1FYSzBUWmN2dHVXekJIYmxHcDA2VE1p?=
 =?iso-2022-jp?B?R3Z5T2M2NjVMZ2lHM282N013Q1JyN1ljMkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e72c22-77f1-4bf6-9513-08dd5a34906e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 09:19:56.4353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8XLK8r19iwwAT5zdtN4bGln545zTFY8ikbweHN6qxuN9wdJLYLbGnfA7fF+nZ8EMImmKlMBJ/sZs67Xsu8G3A2Ks86D4nU8evS/2kJE7k1D8GUgKWX2r3kQ+jyp6m10
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Mar 2025 09:20:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17995

Hi all,

> -----Original Message-----
> From: Paul Barker <paul.barker.ct@bp.renesas.com>
> Sent: Friday, February 28, 2025 12:34 AM
> To: Pavel Machek <pavel@denx.de>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?=
.MN=1B(B =1B$B!{#D#I#T=1B(B
> =1B$B#C""#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: cip-dev@lists.cip-project.org
> Subject: [PATCH 6.1.y-cip 00/12] ravb backports: MTU fix, VLAN & IPv6
> support
>=20
> This patch series backports recent ravb driver improvements to CIP 6.1.y.
>=20
> Paul Barker (12):
>   net: ravb: Fix maximum TX frame size for GbEth devices
>   net: ravb: Fix R-Car RX frame size limit
>   net: ravb: Factor out checksum offload enable bits
>   net: ravb: Disable IP header RX checksum offloading
>   net: ravb: Drop IP protocol check from RX csum verification
>   net: ravb: Combine if conditions in RX csum validation
>   net: ravb: Simplify types in RX csum validation
>   net: ravb: Disable IP header TX checksum offloading
>   net: ravb: Simplify UDP TX checksum offload
>   net: ravb: Enable IPv6 RX checksum offloading for GbEth
>   net: ravb: Enable IPv6 TX checksum offload for GbEth
>   net: ravb: Add VLAN checksum support
>=20
>  drivers/net/ethernet/renesas/ravb.h      |   7 ++
>  drivers/net/ethernet/renesas/ravb_main.c | 120
> +++++++++++++----------
>  2 files changed, 77 insertions(+), 50 deletions(-)
>=20

I reviewed this series and 5.10.y, looks good to me.
I can apply this series, if there are no other comments.

Test:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/169648109=
2
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/169648318=
6

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


