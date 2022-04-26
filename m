Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2105EC433F5
	for <webhook@archiver.kernel.org>; Tue, 26 Apr 2022 07:12:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web08.3306.1650957136287970269
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Apr 2022 00:12:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 23Q7CDvr029502;
 Tue, 26 Apr 2022 16:12:13 +0900
X-Iguazu-Qid: 34trMBIs3ZSf9zbl20
X-Iguazu-QSIG: v=2; s=0; t=1650957133; q=34trMBIs3ZSf9zbl20;
 m=6/vos3Q8Jk4ODqTHIvC0qtCbU2Q6XhgO7kfMBJWtv9g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 23Q7CBip008910
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Apr 2022 16:12:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXAUvS9CfhY3AmHNpUsDMb5qFsb/FtUb6xZ5JSbtrZl8Vj2e1t5THNeaIXwhBZew1ynQ/Ud/VjW87M0w5+4mKqNV4kPKsS5wtTikqIxM6hELcfmpmDjWuKwdMm7v1cYsm5acaOKnmjzthjVR+Y+y5nc0m9/c5+MpLkW18sfI7SCX9F4xqAyDR9vOlBR5QA3P33dfAAXzopYlZ+wXlJsY7ZnO3eJa433RwBUkJWlB0gcN2ANRNSbBhy4JVXbzIRZb8EEVCo74IgVoMAeNoXzy/r2K7WhW5r3QG71w4uSJ5JUtdJQvrYrBfTeWztymvUsRC+76CL2Y5aquttNiOVNTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyBnxdChmEx63cOV4FPUNzV6eG+Hbvax19lqHUNA800=;
 b=F+6roGSvdQptHLOsjdxGAwEK8GyyIrQ2Hq+IbFOjAnkb66PwR8RoMIc4xrC22OmU985VZLbZ815A57jq9konWMzLMPcaFmspUhju60EBx5m0gR49qJHlg42kdW/ZCHwop42ld1sNu22wC6QLYYdQ8Nf1aKyUth0XRQMSPKK0uUpGckD7PEeZ0oH0nzV0M4rfsodecj1lV/Rdw7ukGZXCCIdAZBeA4mE1p4Rdqs79PI+STss1u/Dj8xWl98hi4S1wnyHDHa5jxznrEV0O8bEJRqMNlWyp/e/cVb3h9bENFsqJz3rsMkGyiBDnv/AH0UlxE/94zQykJWLA31SkqU9r+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: Create a shared project to manage LAVA scripts
Thread-Topic: Create a shared project to manage LAVA scripts
Thread-Index: AdhZOpT5o5bNwUdBQVSwy46M9SETfA==
Date: Tue, 26 Apr 2022 07:12:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB8423B96790F7441B249C7844E1FB9@TYCPR01MB8423.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eef4999-73b4-42d3-f9ec-08da2754137c
x-ms-traffictypediagnostic: OSAPR01MB3892:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB3892A7A4BB9BC449EA398564E1FB9@OSAPR01MB3892.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wmwQXbJEUt0oalUAnu7XomApMC1Uug39cBRuEoAPHO0OcBwgeeiV69tPBHo+ywmgUuPBkxUhglcSd96N7fBkJvoKTgSZD+0aqJ/6ql42o+m+Uoe1JrYny74eWymGowslOpP8g13JOecRsCoQH34j+ESjIEU7e2uR7qMDJvCFfleS14aYgd7s7mozfiw4nvTHf6fW62vml+bWFeHMaLpx/RIxpow8U2gNpFgZbK+qu99ZPkQaR8rO+wfXDo3F5Mii4NjEyjXMfEFrr9ynUsxi3dGLmXLr3nUPK1hJHtV5JdOdIXezsc7X1bPI4u0blEkpSWP5fuGuX6JIp7qdFseXexnCdxtk0UBnH9YBMFQFLjcScELVwfIL7n+kKuyBJ/QdF7yuVNS5tQ+wIHLutfaBHhauVNYnwxpx9wVx/+ZlMWASQb8pd/XLc0t5/zlsU6NHyHssGHI3bE2pF1e9zvZxqJDa1ikup/lukftQ/16/tgA4pYKde+Tr/hog6lAxVMa+bVyfb+Pn7lN4HEO6IPL2dIs01wAS2OaHCHAbt1ksYR2utErg/meE1HTU7N9nsSjXYmQoj37ODzFYKQr4UjtqWzrX+KwFC8TUYpDSrtULX54c5nZ4Jxve2wLxxZ6x5EGdWerLS2suKa4Fk70IxhtzO0iiie0QcbHLjHWe83XFsxpxUOZxjmz1kmLmQkZ0PRMkmxjZ3oBhPglWmP5/Tp0s/6/xKFGn58aB7UtOB5Pq7Wh8MHVrTF+oME7F9InWNaw1A7FrS0cx26jMgIIc7o22Agy7sNmR8Vn075jWwzh+jJOhh9zBo9tAR0XcStMIgBMyeguS3a2J/zEhteRoRJIQpQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8423.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(9686003)(38070700005)(5660300002)(55016003)(55236004)(38100700002)(33656002)(66446008)(4326008)(316002)(71200400001)(4744005)(83380400001)(2906002)(6506007)(7696005)(26005)(86362001)(186003)(122000001)(508600001)(8936002)(52536014)(966005)(66946007)(8676002)(76116006)(64756008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y05MUlpVN2lZQ21PUWh6VzdLNXk3aDRleWVORTRCc0VQaFZRajhib0k1?=
 =?iso-2022-jp?B?dWVIckdjalNaY0VUMUJBNzVtSkdQR3o2V3JUdFBWelhOaWQ3SW9EclNF?=
 =?iso-2022-jp?B?SUhnMU42dEgwYTR0dEx5elNlMVdtYnQzWTkvWk01Z2ZjcHArcXpMa1RP?=
 =?iso-2022-jp?B?VlkxQVo0OUIzL0FqMEJSbDdxdmRlU0tpMllWbmFVMDAvWnArdHBjWFNi?=
 =?iso-2022-jp?B?Tmo3WHJoS2tBVjVPcnNYYkRtMjVDZkZzZHl2V1lWcDQxR2dXNFE4anNh?=
 =?iso-2022-jp?B?dUVWemQ5NE9FVys1aWhOM1FqSnhCaG0zR04zUzZLNDRKYno4ODdvWTN2?=
 =?iso-2022-jp?B?MXdOUU0yUk0vN0o2S0htQTNCZnNCeE1kdFRpb3k3cm9LZ3U0WEttU2tp?=
 =?iso-2022-jp?B?Z21ybVQ3UGo5SEtkZGVXbEU3ZHU3NVZ5OHlneTBHeVEwakw2MThVdm1v?=
 =?iso-2022-jp?B?UzhuK0pTay9xUktVZURadUVKOC9aVy9SZTJnVHhURnZXRnphaklPbEZu?=
 =?iso-2022-jp?B?V0h3RklGSWgzMlc1dTZIWFRlcjl6RDRMVzh5ek84VitwZUdQL05Sc0xY?=
 =?iso-2022-jp?B?MS80NXY1ZEhUTnMxcXdOZHlnNWdveGxOZkp2b09YSHo0UTU0K29QNklj?=
 =?iso-2022-jp?B?eTlBbmtndGUveVFrelR4UHZEdEtUOWt3OWRSQ3dPRFE2MHE5WERqbSt3?=
 =?iso-2022-jp?B?TnlEcXdrWm9zZEJHSXBXRzYxYndGaHVMcWkrQ0tpOG50RXV4dEJqYXRy?=
 =?iso-2022-jp?B?T0k3UTVlRFNPZWFVVnNOVStQSWt4R0JSWmRBbjh0L0MxeFlPVlp3S3FS?=
 =?iso-2022-jp?B?eDZObjIyWXR5d3hkaHlIb0JaTzFwN1FBZzh6K3FaQlI5R3ZaazdCcFVJ?=
 =?iso-2022-jp?B?SGk4ZnUza2dSbTRDbXhuUVdyQ010VG9ncDBwZFphRXhNMVZLb3IwZ2I2?=
 =?iso-2022-jp?B?Z0hzN1BUZFd2RFNYM3NwemJWcm5ESG8xRDkwaHRER3dQVkJVUEtjSU50?=
 =?iso-2022-jp?B?R2Z0OGY3V0R5eHZkd0cvK3VHMUFaZ1lQNXM4aDAxYmtlTWx5NlFucy8w?=
 =?iso-2022-jp?B?Y2tzcVNzc3QvbnJsNHYvZEIvYjhJMG9XV0IvNjlVNzYrcTlNK2RYeVpQ?=
 =?iso-2022-jp?B?ckJTcEZVMHEwNE1iYmwxSVdxblBPa253UUxVcjFwT3RIRCtQYmwrVzls?=
 =?iso-2022-jp?B?andDdDJ2K2FmdUFNSitqRmhNRkdITGxPeTJQQ0dET1JFNVJDcEQrbmtW?=
 =?iso-2022-jp?B?engxUFIzb2duem5kQmZKck1iR3ZOU0ZaMUJGYThpampQM2hkMG9hWHR3?=
 =?iso-2022-jp?B?Y1hhZzlaNWdZeUs3V09MWVdDOTFrNzJVR1E5dXgzQjlibUZySW9lbTFx?=
 =?iso-2022-jp?B?N3pUdG9JVVpJS0tZRm5lQkFNcExhNlpzNGxQWlpIcnpNRlV1czVIRWUv?=
 =?iso-2022-jp?B?ampTRGRsSGtQNFhkNi9FRXR2SlVpbWlHYTBZUXM4RDQvckF4aUxBVzNW?=
 =?iso-2022-jp?B?R1Y2SmhUMzh4R0JKMUVjWGUvKzl5NXIveGJFOGJzOUVhU2hPa0NWNitR?=
 =?iso-2022-jp?B?d1dSM1pScUJISFJnaW42UFZoM2o3Zml0bmNCUUEvZVVycGJEWnZOVE5P?=
 =?iso-2022-jp?B?L0ZzRFF0em1QY1pvT1kyVFBYeXR3QWlsRklSTXE1ZmlqS3lUcjMxdzhi?=
 =?iso-2022-jp?B?N0swM1E5VFF3UEJyRldsRWRmdGdkZUNYT1ZsSWhsMG9nV1hZNXhmd0lo?=
 =?iso-2022-jp?B?L0s5aUE5RFpGNisvNGVVMUREVHlrN2tHMGpGTFZMczYvL1VOTnVTSUZE?=
 =?iso-2022-jp?B?UVdMVjUwMHlJeVMrZ0pHVXR1VlArR21UOUdxWHZaZFMyQ1ZUeTVmWENG?=
 =?iso-2022-jp?B?cVhIUUU0di9RYklVeXhHdGh6ZmFCeGYwYmkzb2pQYkd0QkhHWEE1UDVL?=
 =?iso-2022-jp?B?SlBmUFNjUlM3NTBWNTJ0eUlFT1A4QVlTdkVsTzVDYVcyNHdwR0FBbjhk?=
 =?iso-2022-jp?B?YUNXeEExVXVKTGl3NzViNE9rQWk5dVpUWVZiNGp3Y3oxTC9NVVdIV1pQ?=
 =?iso-2022-jp?B?SHVkS0MyUzlXTVg1ajFFekpvUkhTQnk1OThnd01aZ1pMN2RST0pWeE5q?=
 =?iso-2022-jp?B?c3c5UVlpUHFvK09YODE1cXhTc3pQakROZlo1UHRkSlVkeGREV1dsdHFB?=
 =?iso-2022-jp?B?RzN1ZUtlckVnaTRNMTlURS8ydEhXQjY3ZVZvS0JuUVFheTNaOUNWdi96?=
 =?iso-2022-jp?B?NW1NZEpVUHBSZEk2eDU3VGhxdG5pYmdnNHAxakxKSWd1QUtMZmhDSXFB?=
 =?iso-2022-jp?B?cTBvaGRkejdVeDMyQUhDMTM0RG9WelFOem1MS1UyZDFJbllNdzZZWUgw?=
 =?iso-2022-jp?B?eEp2ejBRRWNVMGI5ei9vQ0gwZ0oya1E0U3poUytndEw0K3cvcEpmQWNN?=
 =?iso-2022-jp?B?Zzk3c0JGYlNnTzlGUmpqQ1VnZlZUZ1NXZFBURnRPekZjY3ozM2hSTUg3?=
 =?iso-2022-jp?B?S2V1R29pdHI2SjQ5UFlwblRsRUdIbUQ3T3FpQnF6QXNXb09SWGlJMFBh?=
 =?iso-2022-jp?B?Sm5TNTMwUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8423.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0eef4999-73b4-42d3-f9ec-08da2754137c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 07:12:08.3727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 DR2N1sadg64JVQq4T8hZJIcyRWB/oIxWnErhMaMUJUROMvHaMymLsStvkGo1JTFKWf20b1qr80tHMvRRCFFjxxFnK1SRzCyyGzrASixQZ8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3892
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Apr 2022 07:12:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8218

Hello Chris,

As I created the issue in deby[0], there are duplicated several scripts / d=
ata
to handle LAVA jobs in multiple CIP projects.

Examples:
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/master/submi=
t_tests.sh
https://gitlab.com/cip-project/cip-core/deby/-/tree/cip-core-buster/lava

We are plannning to create a new CIP project that includes common scripts
to handle such LAVA jobs.
The new project can be registered as a git submodule in other projects
(like linux-cip-ci, deby) that depend on the common scripts.

Do you think this change is reasonable / feasible?
If you have any other opinions or concerns, please let me konw.

[0] https://gitlab.com/cip-project/cip-core/deby/-/issues/16

Best regards,
Kazu


