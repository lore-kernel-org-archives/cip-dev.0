Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A16C36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 11:35:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.37173.1742816117321401977
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 04:35:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 52OBZFhb3385334; Mon, 24 Mar 2025 20:35:15 +0900
X-Iguazu-Qid: 2rWhSHZE58bDrSieSP
X-Iguazu-QSIG: v=2; s=0; t=1742816114; q=2rWhSHZE58bDrSieSP; m=WM658uKhUeH6kwqGZ9SvZCOf8ZnDLBftcCWTVqB5QK4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 52OBZDb21498980
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 20:35:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6zPA+OJA8oUtX7RyObLZ5/7zHPaxlFzCs1mIioPisK7KDlHddp3GeFLTIuxRPf6dGT3LbsOGWuH838hD0WRIO+L2Snxc9HY876klAxqRhi4LDtwv5uCA0ov+Fxd7Xs/O4z1zP9Q0y/Pre+nI6H4IwqnI2temXIoxQ6+NeTpCrNUBnEGA+w791XMFCXydpbSWQMkpm5xLAc2HLB7QZviQU8+pMXhxPbA64tLn/R9I37ZPZfXrDwzauURomYdQEt/sniGf4m62vw8hmEBE+3baSXp5Hgl+bOmu7qJrJ0C2CNLIeWfU9byyXw6K4Y+Qcd0JoG45Uq2fNfalF3+r1mycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca23neqtA/tlpbc9ZV+Wwx2BzKiFcwHzQ0BvQ8yrPtI=;
 b=eFhoRUi734dWKW5ObnWXb0yci2LusHsSWw0a7UVSnxGDnXfzkIsx9nt/oJbJIG/RYSZY+TZcDN5ZdrJ/5XeN6VJ4nLZbCa2eoLcfFRsi05GNK/exqqzBM8Gk8FrV1QM6M3zi2pXoWCrIWiM/x8owO0USJKzV8oe1gCrW1H1uvyRSE9q8b/VoazRNFx74G1WeklyUWO81z3gbBT8qdIfKZaeVrz7MPr1SBqxXLrM6dBpyf6hywhXKEwBHVbauUVCbLNL2s+J5ijNUiZOjpSSz5mi9uiZmT1LHxFgoByAPJpdjIU80YmCSU5ffsCAiR5m5SJsTyL+z0sPkoi7Qu9fNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <quirin.gylstorff@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home partition
 for qemu security targets
Thread-Topic: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home
 partition for qemu security targets
Thread-Index: AQHbnK9nqUOYqApi7k2+41qxWTvRo7OCJlOAgAAAZmE=
Date: Mon, 24 Mar 2025 11:35:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB14838A47CBFE9609D5FF0D806C2A42@OSCPR01MB14838.jpnprd01.prod.outlook.com>
References: <20250324112155.3051460-1-Sai.Sathujoda@toshiba-tsip.com>
 <37053ef1-be2b-442d-b4a9-9da99e75671f@siemens.com>
In-Reply-To: <37053ef1-be2b-442d-b4a9-9da99e75671f@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|OS3PR01MB8681:EE_
x-ms-office365-filtering-correlation-id: ee6ac7b2-0ab1-43cd-5084-08dd6ac7f02f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|13003099007|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?U3FrL3V3SnNhRENCUzJUS243ZmhlaXlnTHJ4N2pFYzJGRTFHUmlBQjZR?=
 =?iso-2022-jp?B?YjZ3WWlUdmduT21PODRzZ1Z0UmJvU2tvZWRzZTNDQkliVHh0Z2hZSHAv?=
 =?iso-2022-jp?B?bzBocE1wSTFhSDZSTlBjUC9tYkNlT0phelgrQTlUY3pteXRnSEpNNjQr?=
 =?iso-2022-jp?B?ZU1ULytkUGNIVit6dUVkTXdCenVWeFdGWENCZ0ZFY0YvanFaaHh4ZnNZ?=
 =?iso-2022-jp?B?QjZNRmhYUFZmN01xZHg0bUdEWjBGVlZCTUE4c0JwdXpqQ3pqelNoQ3FX?=
 =?iso-2022-jp?B?a0FTS0hZQ2xuVCtvdmwzcllKRjkzYktEZ0lvVlQzSVRPME5JK0tvakNp?=
 =?iso-2022-jp?B?ZVVLOU84VEJGZ0lRK0JhV3RZUlc1c3FIZkMxTFJlaDJBWE5EUXg1eElO?=
 =?iso-2022-jp?B?Q25IbzhMTnpnd2FYbWFZR0dnYmFLaVRQbTEwaHYrbm91TE04TStUMTB3?=
 =?iso-2022-jp?B?MzNrUmhRTXpYcmJQdnltdi81L2h6QTVhVDBTMVlkZFFwRzJ2ZVNHU2ZH?=
 =?iso-2022-jp?B?ZWRpUWhJc2MxdjNoZW5WYUF4SHpxNjU2WkNpbWRoZzEyZEtRQjhMN2hZ?=
 =?iso-2022-jp?B?OWxrVWZXNzN6Vy9zOStvNTV1dGlHcm1pQnRBeGgzRUtkV1BuR3RMNGhq?=
 =?iso-2022-jp?B?UzdtemErMUQ0c3U0YUVkeUUxMVllNVFBUnBuUjJZcC9CWGJIVStMaFBh?=
 =?iso-2022-jp?B?SVg5QitUcHB5L1BpTk9pVTgweStoZ3l3b2t2UGIwTGthYlMrVzdESFNF?=
 =?iso-2022-jp?B?d0dQWC93Y29VbmgrQUlKcHpkVTBYOVF2MTFvbmJ1TFhFRFRWMy9RUHF2?=
 =?iso-2022-jp?B?SzMvOUxuSjZzdmdwMW5Sd0M0WmtYMjRnT25HQXp6eE9ubThSN0lKQkFW?=
 =?iso-2022-jp?B?ejdjWkJjWUJ5ejBaaSswakFUNEtOdU14RHVFOVFUMFFIVTd3TjRWemln?=
 =?iso-2022-jp?B?cEFVcVYyeWR0SEtMMUt3Slh6QklmK3o1TXhPREc3OXZpbTYvUXV2MWRW?=
 =?iso-2022-jp?B?WkswWURiejZsVUtXR0Z1RVlsQWZwaUhQdU9hTEo2cG56ajVvanE2VW1H?=
 =?iso-2022-jp?B?eEJPT3FWNmxWUWhhU09ZTFdMdnFmTXBzN3RUQXVrcnhXQjVHaVFMcUQ0?=
 =?iso-2022-jp?B?KzVqUWNySGxrWGtabXI4NGYzSm1VTkFrekU0WVJJbHZSTVMvbnBsWW8w?=
 =?iso-2022-jp?B?SjkxczJwRTk1bVhwR3V1ZE1EUHBRZXBWVDc2UDh6bjFGQkxPaFU5engr?=
 =?iso-2022-jp?B?bmF0d1Q5Rk9sb0pOQmMvMHlLb1JUdzFneEMzYUZENHY2S0ZaMWwvZDM0?=
 =?iso-2022-jp?B?cm5lVmN2eVFCZ293RFhEV0hodTRzM3ZxTFZEdlZCMWVUNkJXdHpKbHQy?=
 =?iso-2022-jp?B?QjVleE1ERHgyNjBoNGNQZkpPRFpLR0VMT0ZqdXBhWExOb0tud2FzUWhM?=
 =?iso-2022-jp?B?aEV3ZkRuOEVOY2lBNzlQUXFSS0xVNVVuTmRYTGkzSnQ2cmRCbmV0a0E2?=
 =?iso-2022-jp?B?d25GRytiZDZIbjZKM0hvWDNBTGdFM2Y0NzFpVXdqUTFnL0lXTitleERy?=
 =?iso-2022-jp?B?ZGNpYU50UFFFcmliV24rTFdSMEora2oxekVrS3JLekd1UENsbkhzTVN3?=
 =?iso-2022-jp?B?dUJ4NFVLN1ZiSXlGY0NQUkJVQWNBOG9vVmVCTVFuN2MrT2xTYTR5Y0hu?=
 =?iso-2022-jp?B?NXdBcFZqSkhXZ3E0SjRnV01YWTlMSU1LNGk5Q2dmNE1kWmI5UkRJbStR?=
 =?iso-2022-jp?B?dGhEL1JDakw3US9EaDNrLzZhZHFJYmI1dUVHS1VSS2xBVHVpZGVMY3ph?=
 =?iso-2022-jp?B?Nmt1YVltbzhKL29OUGl0RStCbkZJbndmTDlick5QRVZmUVhZNDA5cU9y?=
 =?iso-2022-jp?B?WEJmWW9HTURUWXo2T3A5dE53VHk2Q2o1RlhGVlg5Wm82dUpYN0VIYmh2?=
 =?iso-2022-jp?B?MHZjTTBhMVZ1N2hpUWxyL0NwdWQxZGd1NVRCUks3Y25DbEtwZERkQm43?=
 =?iso-2022-jp?B?eEJ6N0xueUI0ZnAvblBjRjZyWVNCYTJyVEFZT3l5QWF1U0ZRRzRSMC9p?=
 =?iso-2022-jp?B?eEpEOS9UVE1YbkFkOVJZZXZVam13bzg9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(13003099007)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QjVON3loM0JCUFo5aEFGM0FZVEhjTW03ZXZDU0s3S2IzMlhYWUZCT3Jy?=
 =?iso-2022-jp?B?cWsvOFdRMnJRdllZdThYWWxNMDlrOGhQbVNnSjIvTkRNdWtWTnRpS0ti?=
 =?iso-2022-jp?B?RnFLYUNSMnlBU0ZVc0lKZTd1eHVSNUtNL2dlRU5pd2F4djgvVTZxbWZm?=
 =?iso-2022-jp?B?YUdkQmxRQVp3MjJtUjZYQ0U2dHlJZ25hWlV4YndZenVQMDJ5a1RHL1BN?=
 =?iso-2022-jp?B?aDRIa1VnY0h3aERvNmo2NTU4OWtIazVyYU5zMklES0RKNW9ZR3pHR2o2?=
 =?iso-2022-jp?B?S3Frb3lFN2pNekllMEhGMEJRbk42V2VUR1ZUZ2hZOUVxOTV2UHFZRk0x?=
 =?iso-2022-jp?B?YkJGV0ZiYTNUQjM5NGtJY0JVK3JJV2FaNENkQ0R5VnkwZ3NQOFhvUXZ5?=
 =?iso-2022-jp?B?NmJ1aEtBZDdVazJ5UER0RHpsTG9mT3YrRlZMUjFnd1djRFliTzk5VmVV?=
 =?iso-2022-jp?B?MXFWUmZrU0NuVWQ2Uk9VdldiOUxmUE56eTIzS2FjN0NLdFI0MVdNWEJH?=
 =?iso-2022-jp?B?M205WllhN3l6S0RwcVd0Q01lS2M0eDliYkJSMWk1U2MyZEtpN21PR2Rx?=
 =?iso-2022-jp?B?ZGNlbWM0enZjMkhhOGcvUG9OUHJoSW1lQzNKSVV1WWVYUEdFR3VDV3FV?=
 =?iso-2022-jp?B?alpOeC9hc0I5QlZsWHNzNzlmdXQ3SktZdE15VU5VV1UzM2FhdmZZOHYx?=
 =?iso-2022-jp?B?YnZOdTJwMGxIWXQ0U0VJbGhKWEhMVGs4a1BLbWpzVnVqRHczLyt3VzRv?=
 =?iso-2022-jp?B?VWUxWWlwNTBJRjJNcjExUC91TEQyQWZJWUV5NDZ2V2xhQmorcWFoR2xx?=
 =?iso-2022-jp?B?MnZnRGpjUDhrZlo3eE4yZ3UxWmUzMCtPK1JiVCt0UkdTcEpob05lL2lw?=
 =?iso-2022-jp?B?MXN2YzdWalVVbzJwSjEwOU5QWVJGcmh0NnQ2Z0tpb0ZWS2U2U3JnZGNG?=
 =?iso-2022-jp?B?VHlDV0RwVGxHTGNqVXRYSXd5WFc1UEtiRDIyVVJUZDMrQUgwcUhrRXE1?=
 =?iso-2022-jp?B?ZkdpK2tlS0UrWElsUmtKTUkzNlAvSWJYclpzM1JqaWhEdHg4em5rS2Ft?=
 =?iso-2022-jp?B?NVcwVTdKUytzdVRHelE4ZkUwaStNRzNsT3V1V0h3QXh3LzlvaUx6dWF5?=
 =?iso-2022-jp?B?M1A2NW40dmtnbXUza1AzUDMxRXNGZWdvdjFJMnpWUml2YTdIeXZOcm10?=
 =?iso-2022-jp?B?OVJnaGlkVnltT1RBbTJqT2VFeXdnYzhnaHpiakhRbStXWW5saDRzR3lU?=
 =?iso-2022-jp?B?aG1nNU5UKzJ4d3M1K3NibU9ZRG5LcGtZbXNqY1huMk1KdFU0ODBBTTBM?=
 =?iso-2022-jp?B?U2UxRFZlejROVXg0WjlHWnFFcG1XWEljZnRKV2ZNVGpUMGZGeXNNbGJ1?=
 =?iso-2022-jp?B?OElvTjZreEtMMEZLZm9mR2R5eUt3TzdPdWgrNkJtendtc3NsRWhOK24r?=
 =?iso-2022-jp?B?MlBhTU9ydmI1UGJhdjY3V0FJMXN3M1ZBMEN3bEd3N2U2RkdYb0NPWDVj?=
 =?iso-2022-jp?B?RGQveVNDTmFROVUzWUhJZUFzU1lBK1BJRW8vejZyZmRncjhSOVcydVZ5?=
 =?iso-2022-jp?B?c1BOMmhScThyWitHSkpUMzltSmk4Mm5SRER4N0lOcFpyZ3cwMnZlck5B?=
 =?iso-2022-jp?B?VkRVWkx1MWxzVXhKMlBqUStOcXp0NFlZcjE5N3N1QitRNmJFR3JJR1lZ?=
 =?iso-2022-jp?B?Z01LcTRTTEF1clNTbzJpRVUxaXhIQnlsZXZIRHNrZmMvdjhvMVR1cG5R?=
 =?iso-2022-jp?B?RC82U2NCcHRsUFdUUWRCK09MWHViNFZPWGprUmd6cUlxYXBMcHZPcnRa?=
 =?iso-2022-jp?B?M29BWWpFR3BaZFdyb1VweXFWVHpSczlNa1FXaWJQUEdmNWtHV0J4VXBz?=
 =?iso-2022-jp?B?T2RlSFZmUHlQYWdaaW1kVHFEemhTMmtKZlhJUDVORzBhUUNVYTdZUHk4?=
 =?iso-2022-jp?B?ZWM5aXFUWVVlM0gzS2NIME1UaG00aFBIRXVtUjU0WHVhWUxscmRVcUpp?=
 =?iso-2022-jp?B?L2hqVjlFUFo1N3U4a1JzS0NOYmVNdG05Um5LRXVLWWI2TjNhT3hzWGxJ?=
 =?iso-2022-jp?B?cHMrdE1nV3BkemtFM242ekxpQ2szajA5cVZBNkk3OVBDUEhvejcvK0Vx?=
 =?iso-2022-jp?B?eHB5MDVEWTIzcnRsYk9LbGFvaHU2NVF2Y1dYTkZQaGRXV1Evc01yOHFS?=
 =?iso-2022-jp?B?ZkkxSmlFUWorSDFrZ0NZNU1ENW9zTVhzMEl2VzE3UWVBN3BSc0k5V3Ux?=
 =?iso-2022-jp?B?UjdpSjkxd0pIRmZyZUgrbVdsWDdiUjJQRG9lTzZMckw1VnFHb21mQ0RQ?=
 =?iso-2022-jp?B?TlkwUGl3T01mZlhRdmxCclhER3FVUTFhSmc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB14838A47CBFE9609D5FF0D806C2A42OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6ac7b2-0ab1-43cd-5084-08dd6ac7f02f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 11:35:11.6877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ir47aTy5E1apFXjSDc9FZtUo0QhkD5QRAm2K2NHdh8kHBTAW612hfEVZPN1cqtMl0qgbASV40wHiNS5sB4NQYzI/ojGrs4YRIu7gdPBOl/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8681
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 11:35:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18343

--_000_OSCPR01MB14838A47CBFE9609D5FF0D806C2A42OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Across all QEMU targets, the mentioned test cases are failing -> TC_CR3.4-R=
E2_1, TC_CR3.4_1, TC_CR6.2_1

All three of them are related to aide where we explicitly modify a file and=
 check if aide is able to detect that. If I run these test cases in /var/ho=
me/.. Aide is able to detect that the file has been modified reporting an i=
ntegrity failure to journal logs. But if I do this in /home as working dire=
ctory to run these tests, the changes are not detected.

We can also change the working directory to /var/home here, instead of depl=
oying separate home partition here -> https://gitlab.com/cip-project/cip-co=
re/isar-cip-core/-/blob/master/tests/templates/IEC_template.yml?ref_type=3D=
heads#L74

Regards,
Sai Ashrith
________________________________
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Monday, March 24, 2025 4:58 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsi=
p.com>; cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; Quir=
in Gylstorff <quirin.gylstorff@siemens.com>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B=
!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home partit=
ion for qemu security targets

On 24.03.25 12:21, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>
> IEC layer tests run with /home as working directory. aide is unable to

aide?

> detect changes made to a temporary file created under /home which is
> now symlinked to /var/home. This resulted in failure of the following tes=
t cases
> TC_CR3.4-RE2_1, TC_CR3.4_1, TC_CR6.2_1.
>

Is this a limitation of test cases or an issue of our merged home
partition approach?

Jan

> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ec9ec2e..146eb33 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -122,6 +122,7 @@ build:qemu-amd64-base:
>      security_test: enable
>      use_rt: disable
>      build_swu_v2: enable
> +    separate_home_partition: enable
>
>  build:qemu-amd64-base-kernelci:
>    extends:
> @@ -142,6 +143,7 @@ build:qemu-arm64-base:
>      security_test: enable
>      use_rt: disable
>      build_swu_v2: enable
> +    separate_home_partition: enable
>
>  build:qemu-arm64-base-kernelci:
>    extends:
> @@ -162,6 +164,7 @@ build:qemu-arm-base:
>      security_test: enable
>      use_rt: disable
>      build_swu_v2: enable
> +    separate_home_partition: enable
>
>  build:qemu-arm-base-kernelci:
>    extends:

--
Siemens AG, Foundational Technologies
Linux Expert Center

--_000_OSCPR01MB14838A47CBFE9609D5FF0D806C2A42OSCPR01MB14838jp_
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
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif;">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0);">Across all QEMU targe=
ts, the mentioned test cases are failing -&gt;
</span><span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">TC_CR3.4-RE2_1=
, TC_CR3.4_1, TC_CR6.2_1</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
All three of them are related to aide where we explicitly modify a file and=
 check if aide is able to detect that. If I run these test cases in /var/ho=
me/.. Aide is able to detect that the file has been modified reporting an i=
ntegrity failure to journal logs.
 But if I do this in /home as working directory to run these tests, the cha=
nges are not detected.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
We can also change the working directory to /var/home here, instead of depl=
oying separate home partition here -&gt;
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/mas=
ter/tests/templates/IEC_template.yml?ref_type=3Dheads#L74" id=3D"LPlnk">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/tests/t=
emplates/IEC_template.yml?ref_type=3Dheads#L74</a></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jan Kiszka &lt;jan.ki=
szka@siemens.com&gt;<br>
<b>Sent:</b> Monday, March 24, 2025 4:58 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Sai.Sathujoda@t=
oshiba-tsip.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-pr=
oject.org&gt;; Quirin Gylstorff &lt;quirin.gylstorff@siemens.com&gt;<br>
<b>Cc:</b> dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;dinesh.kumar@t=
oshiba-tsip.com&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M=
#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.c=
o.jp&gt;<br>
<b>Subject:</b> Re: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home=
 partition for qemu security targets</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 24.03.25 12:21, Sai.Sathujoda@toshiba-tsip.com =
wrote:<br>
&gt; From: sai ashrith sathujoda &lt;sai.sathujoda@toshiba-tsip.com&gt;<br>
&gt; <br>
&gt; IEC layer tests run with /home as working directory. aide is unable to=
<br>
<br>
aide?<br>
<br>
&gt; detect changes made to a temporary file created under /home which is<b=
r>
&gt; now symlinked to /var/home. This resulted in failure of the following =
test cases<br>
&gt; TC_CR3.4-RE2_1, TC_CR3.4_1, TC_CR6.2_1.<br>
&gt; <br>
<br>
Is this a limitation of test cases or an issue of our merged home<br>
partition approach?<br>
<br>
Jan<br>
<br>
&gt; Signed-off-by: sai ashrith sathujoda &lt;sai.sathujoda@toshiba-tsip.co=
m&gt;<br>
&gt; ---<br>
&gt;&nbsp; .gitlab-ci.yml | 3 +++<br>
&gt;&nbsp; 1 file changed, 3 insertions(+)<br>
&gt; <br>
&gt; diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<br>
&gt; index ec9ec2e..146eb33 100644<br>
&gt; --- a/.gitlab-ci.yml<br>
&gt; +++ b/.gitlab-ci.yml<br>
&gt; @@ -122,6 +122,7 @@ build:qemu-amd64-base:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; security_test: enable<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_rt: disable<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_swu_v2: enable<br>
&gt; +&nbsp;&nbsp;&nbsp; separate_home_partition: enable<br>
&gt;&nbsp; <br>
&gt;&nbsp; build:qemu-amd64-base-kernelci:<br>
&gt;&nbsp;&nbsp;&nbsp; extends:<br>
&gt; @@ -142,6 +143,7 @@ build:qemu-arm64-base:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; security_test: enable<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_rt: disable<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_swu_v2: enable<br>
&gt; +&nbsp;&nbsp;&nbsp; separate_home_partition: enable<br>
&gt;&nbsp; <br>
&gt;&nbsp; build:qemu-arm64-base-kernelci:<br>
&gt;&nbsp;&nbsp;&nbsp; extends:<br>
&gt; @@ -162,6 +164,7 @@ build:qemu-arm-base:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; security_test: enable<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_rt: disable<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; build_swu_v2: enable<br>
&gt; +&nbsp;&nbsp;&nbsp; separate_home_partition: enable<br>
&gt;&nbsp; <br>
&gt;&nbsp; build:qemu-arm-base-kernelci:<br>
&gt;&nbsp;&nbsp;&nbsp; extends:<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</div>
</span></font></div>
</body>
</html>

--_000_OSCPR01MB14838A47CBFE9609D5FF0D806C2A42OSCPR01MB14838jp_--


