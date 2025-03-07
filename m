Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24461C282DE
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 14:27:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.12206.1741357610871411614
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Mar 2025 06:26:51 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 527EQms21529123; Fri, 7 Mar 2025 23:26:48 +0900
X-Iguazu-Qid: 2rWhEqwpjUq45Cb4jI
X-Iguazu-QSIG: v=2; s=0; t=1741357607; q=2rWhEqwpjUq45Cb4jI; m=FFgaSX+s9zOs4J6JUb82+IJLaHEoFY76VzCsuT2iCLo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 527EQktR3734958
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 7 Mar 2025 23:26:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzGkiSeHUnfQJ378+5gq8bcU7pg0Y5Fh0YUutcmLCh7sjgVfAr4+5v0eUdHAxzOYMjhMwXwn7gOveaCcVXgerv/rAsF0knUvuiRk11oh0KQQS9nizx2FZpsQnKJjuYaJKXD267aw7dkWlc8CIdiqXvS3FIwqZ9fovwDyyUY1FyUs6EW7mwDcnqXG3uEesnaHa/PHEpXT9Z6A0JF21vHMIU1z4tUHF2wC1jkjet36Nu6SK2+LFk1UwfwW76UgfOGz+5MXgyoIl0T3bxHW6DCptJNdySDwOt/7vTYmOkEmA+T9IvxugOrgt5Bf3kp2dS9VABmtqm2Q5joVRiBK8mqZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0MVYUDKTHiwZqjW49upg6DLlSqCCQZ8rA4z3DDWLBQ=;
 b=NkLHbVoe74XhfuM/8Saos4Zazjvv1NPBRbeSMXtrHb7/q2qadMJr21czQVCgj8uLkKQA3BSlQERA4B9BrpAf7VE8+VInjl2x2w/cFoQyevU3VlqIwsHzWz+gxAk+vFdX5WeikGhGAuwn+3SUykwh5rbGuVdi43eaJT3AMA63j06yqtmYs+Vi3y9Km9aKuyL0LW7bl/Ir4e4wNe+GqoPA1kMQMxkDTwAis+ytZLtP8EV5p0DLT4F/n1U479ensfgT454eOr/8i0XrHyzkmzAL8UuSkIWMlFgQ7/vu4Yh4HMnZL6sXthPd1sqVQQMR5yfcP73p6lxZ1hoihPrk7TNqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <chris.paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <jan.kiszka@siemens.com>, <Sai.Sathujoda@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: LAVA templates in isar-cip-core
Thread-Topic: LAVA templates in isar-cip-core
Thread-Index: AduPX1w73+S62qd1SRCs5UMrnumWmA==
Date: Fri, 7 Mar 2025 14:26:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB11063DCBCB8B1B68822A14A84C7D52@TYWPR01MB11063.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11063:EE_|OSZPR01MB7083:EE_
x-ms-office365-filtering-correlation-id: 47650905-35ce-462d-8fb1-08dd5d8414df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018|13003099007|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?YzNRb0p2cXUvNmU4cWNxUXptMzJmaHBqdmxVSnpGRnYySFhHQnNNUURq?=
 =?iso-2022-jp?B?SlhoUTI4cmlWdCtiT1lma2pma0NRekVQT2xvcDVKR2FZMkVBNG90cVFK?=
 =?iso-2022-jp?B?SWNKS2RJWDhPRmtGU2JwU2g1UlAxSHR4eE1YNFYrZWVJdTRFZUxhYW9L?=
 =?iso-2022-jp?B?a0prb0lxU1Nta3JGenJyWlVoenlnWEFhMHNaWW1vUGpsakpPbDhYMGhX?=
 =?iso-2022-jp?B?NlR3S25xS0p1Q2RzSGZHWG1nUFZSTENlclFuQ2lsYlZmbFYveEZ2TnU3?=
 =?iso-2022-jp?B?Qi9lZUZYbGlyWjd5bFRKN3FPNGNndjFrQjcrdW1uSGlBYVRMVE9DZE9O?=
 =?iso-2022-jp?B?SjdLbWFWUGhyam5LbjRkS3BMZDZ2eWV4TWwvNFM4VUlSMFkxL1g3T2Ix?=
 =?iso-2022-jp?B?SDVrSG91SEhBS0o0SmVpejlIUzJ1N3h6NlRKNUFGQklMdW8yL3o3TTFV?=
 =?iso-2022-jp?B?dDBSVE4ycVltVmxZNUxHRWdhTVlQNnE4M0s0V2NHTEpnVnYrS241M1RR?=
 =?iso-2022-jp?B?c0hpUXpQSHNLSVlhY3JjZUNHcWgzM3VrY1NibjZ4R2V6OXdXQ2JoNXgz?=
 =?iso-2022-jp?B?aXZTeFJIbnhRaHlhSW9UaWYvZjVZY2RXZklWYUExYjV4Umo4L0sreEtN?=
 =?iso-2022-jp?B?RDFYVkUvYlVkOVdYVWYrVFhlSDYvcVZueWhiQkxESjE2dDJ0Yi9oWEtR?=
 =?iso-2022-jp?B?UHRJeFM2U29kdUZvRmowbFJpajVNWFd4V2MzUWJzMkwrSk9XQmExTHdI?=
 =?iso-2022-jp?B?ZkJUS00zamJyQnI2RGJhYmt0c0ZNSHQ4anRqWGgvZE9jNkpSWUJKeDc0?=
 =?iso-2022-jp?B?bnhySzB3WlJHbkRoMUs5VVBxOFVVUTB3b1JubVFaejlCNUwwdy8wK0NC?=
 =?iso-2022-jp?B?SUZKODRVaEtUWHpIRThoMkVUWjJRMGU5VjVJWFFvR0F3VUduUFlmT0Jv?=
 =?iso-2022-jp?B?UXpSZnpYZzdXcHZWd1NQYms5cWsxd2x4d05HS2duNitjbjQxQ01GaDMw?=
 =?iso-2022-jp?B?bXZkdS9SN3RDc0RQRUdmR3EzYWpCeHNPUFJsUjcrVTkzam1qMkExNWpS?=
 =?iso-2022-jp?B?anVaNVlIbEZxajFwbG9PTTQ5TEFBdmVxMGZnY0ZCaFBiQWlkeGpoUzZ5?=
 =?iso-2022-jp?B?ZS9XYS9MdHBGTnYrc0szQjlya1c4VWZZcHZ2NzM2QUlGUk9HSXhYQWpK?=
 =?iso-2022-jp?B?SVFWanRqOUNCZmk4VU1RcUVPTjZIZkEvdlYwNzhGMitndjBXdGRoSjZt?=
 =?iso-2022-jp?B?YTFzb0h0ZHR3V3hOanRCQzRYTHpMbUZlR1NyekE4SmpSSnR6cGk3Mm9o?=
 =?iso-2022-jp?B?M1ZITDJzQmZDMWRLUkdUWkd4cjhkcmVvTTlmUEJUVG9TYlRKbnVDcHV3?=
 =?iso-2022-jp?B?MXJjSWFDcWtYTUt3SjZ4dzNTRW8yK3VYVFBJRUw5OGMwWEFiTWhtWFBC?=
 =?iso-2022-jp?B?dWpjcTErclRSaFcvQ2FnWG9Qc01Ya1p2bzdDR21qcmZ4ZGxiaW9NRmIy?=
 =?iso-2022-jp?B?Qm9BeG1IVkw1bWJKeDdSUXJtN1NPQ0ZEKzVJc0gvcGhpYkllK3UzRlIv?=
 =?iso-2022-jp?B?OUg4NnVVU2hyR1Vqd3VBc2l2TnZMdThzejc3QVJFL0JoTERvNFcyMjNG?=
 =?iso-2022-jp?B?WWh0VnpLZU1JZ1FISEtXMFBzeWtmWEVsM2JBcVR3dElQbXRMQjNJbkxx?=
 =?iso-2022-jp?B?UEpLOXRxNzBaZGY5U3JVa1NUTkFUQkhXUE43OXoyZzRidWNHM2M5amlq?=
 =?iso-2022-jp?B?UGc1NFNYT1JnTGxoQmlsTGtTY0diVEg1SUdkL0pDOVdwTWxBMm84VnlH?=
 =?iso-2022-jp?B?RWdmRjd6cW9VN285QmFDM2pTejc4UE43T0hWSWpDczNvRlNrNis3RWgw?=
 =?iso-2022-jp?B?cXJtQmRMSWhmdllTYjVvZXdncmhYd3BtenQ4M0g5STh4K2U0dXl0cXEv?=
 =?iso-2022-jp?B?OUhzMzM3T1RoNHd0aVlaTmtGN2JHeTlObEJLVUtnY2g3SEZYbGRBWEJT?=
 =?iso-2022-jp?B?UEtkNkJNSVVUdHp2Z0VkK2dsWGllbEovbHBsTG4zSDlnSEpsZ2NMbXF5?=
 =?iso-2022-jp?B?YXZWWFAzTHNvSGk5QWx5NWNudlRoMktjakNjMVdtZ1M4MnVEWi9YZFFz?=
 =?iso-2022-jp?B?Sm1SckJScmR5NnV2RWZJcjRyWCtWSDBnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11063.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018)(13003099007)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QmttUHlhaDBCVFdTRFZHOGRGbk9ZMXQ2TU9oN0RHamFHbTJMNzNTSTI5?=
 =?iso-2022-jp?B?RXNySlNMMnBnTTdFSUFJa2NRZzl6TWhWYUtqTEYxRHJ5YkFuOU5vVjFF?=
 =?iso-2022-jp?B?OVZLeW4wcnp6dDBMenQvbEZTK0xoUEhBZGZIK21ja0lSMTJDUzVMeDFi?=
 =?iso-2022-jp?B?VFRidTZPTzJSRjNudU1pRUVkc0tUVG03R1E0WnVFeGdWY1dxNGdZS0RQ?=
 =?iso-2022-jp?B?Z0p2aHlXT1l3RVpyc2RIZXhBT1dHSktlS3J0VlJ6NWx2TVU3bGFkcUtq?=
 =?iso-2022-jp?B?UCtldUtuZkZjMDlkQWJIdmZzODFnbEtDN3VMbVN0OXpIemRRazRNblNX?=
 =?iso-2022-jp?B?akVVREZpSEpyaVJmdDNRK20zZmUrMVpnbTM1QUUxU29xNE84eFd3WW1U?=
 =?iso-2022-jp?B?aG1aMWlDaUF5UG9acmNXUWtPOTlURTdadEUwM3RSZHlTbGNNWjRtbjJa?=
 =?iso-2022-jp?B?bTZDMUIyNXJmV1VjQkx6OFhmMmdPNnQ0SGpTNk91QXh0b0dRSVpuc2py?=
 =?iso-2022-jp?B?dVV0TCtxVFdOc0xGeS81RGRIQ2pBOE1QRFA4TldXSktTaStDREZLeUdY?=
 =?iso-2022-jp?B?VjVFS1l3aU0rbTZUOTN5Q3phZTdMcUdaeDdZOFpmeFBhVGgzM3c3czlk?=
 =?iso-2022-jp?B?R3hpOTJkenUrc2VqWDZVMG40Y2x4Qlgxc3hnakI2alQ0M3ZXY0ozT3N4?=
 =?iso-2022-jp?B?cmFTaVdVaXVyMjhxRXNZVUlPWCtVMFhWMkJlZWdsTG9NbU1pdlpHYTVt?=
 =?iso-2022-jp?B?WnZjZTc1WDZ3d0ZUcHNBM3lFekt4WEZYOUtiZnlFcjlnNU9YYkNyeThk?=
 =?iso-2022-jp?B?Z3JqU3BhWVlVY2pWdnpXWTdwK1k0WVd2OUdtaTlOK2pxSzlJdXFBRTVY?=
 =?iso-2022-jp?B?SDNTSmxLZTczVUpLTWFxTmR5dk5FY2JzWUJlVlBZdWJTQkZnUnp0VC9k?=
 =?iso-2022-jp?B?anpYT0hxNDZXNVVvWXNPM1FzKzFBOFNVMHpnVFBGQkg0Z3VObUFhT3pu?=
 =?iso-2022-jp?B?aFZDRVhJeUk1bFlQMnBvRC9KZzVkbmIxRnVOamJyY0U1UzBNcWpoekdy?=
 =?iso-2022-jp?B?Tnl2dmQrd0Z2VDVCRHh2T3p0OUVMTGFkS0c1cWw2OHBZaUg1Uk41ZVlU?=
 =?iso-2022-jp?B?Q2hZaDJhRnNUU3pUQW9aS290OFJsWllvQlVkNGVPaUgyampzWm5ieFg4?=
 =?iso-2022-jp?B?OExSTVpNNEZSbmZTc2cvcnY5SnJtOVA2VjFqUWoyWThwZW5LaTdBVko5?=
 =?iso-2022-jp?B?WVpyK2NmaDBEMXJpZW1CWDNHWi9NZVZWUTdYZlRFT3pyMXpKdVQyVUFB?=
 =?iso-2022-jp?B?ZDR5Z2dWckhWWFdWY0tjaG9RY3FsdEx1OUtUZEZTNE9nOWYvYWRLQ0Q2?=
 =?iso-2022-jp?B?eG13ck9zbmZjRVhoaXd5MWNpc0cySC90Ukg2T2tYamxlQlF4Q3hiOHRa?=
 =?iso-2022-jp?B?TlFiK0cwNEY2Y1BlMU5iL0RhNkYzWEI4V3BNYUNmV0Vub2o4S3kyVTl5?=
 =?iso-2022-jp?B?Uityak9jM1FVSFc2UkFlQnBwUUZ2TFZabG5vaWRlcTJXU0tLKzBNdzJh?=
 =?iso-2022-jp?B?NmZNcW1EQ3dRckdkRFM0RDZNeVZkV3RPVlFzd3JUc0t4b3RlMHRNWUdx?=
 =?iso-2022-jp?B?d21mSGRUeGQ0NU9YVTNreDR0dlptdVJPeDA0S2J6VGNSZnp2ZGsyWjBC?=
 =?iso-2022-jp?B?U3hOQlR4SitaWTFkaXdVNkc4d0FiWnY2R2VPd1g1cXRZdTJrWWxHU21r?=
 =?iso-2022-jp?B?WnE2em0vRm11NlpCWWJ5cVJDa2lDYUw0aW5MeWI4bG13SmJ4dkxYWGlz?=
 =?iso-2022-jp?B?NWp6WlRWVUhWV3lZSmJqT2hOV2x3ZjdGMG10YTVFSU9ISDB6M0dNT0s0?=
 =?iso-2022-jp?B?RFMvWG1lWUZLWTNSMFZGTjNJdzdobmZNQkpnaGVGdU1pTzRIZTR4OTJ5?=
 =?iso-2022-jp?B?MFFOeHhRa1RlMHRieGxLWVU3NGowUTJ1eVFWeGh2dnptREVZRDJoeDZr?=
 =?iso-2022-jp?B?MWNkN3V6ditldjNrdnFoZmxGdy95VndvcVg2a1UranJHMFNtS2krY2FG?=
 =?iso-2022-jp?B?TEpZa1duc1dpdm9USDdjTE1DOG5yYkIrUjB3eDhoNDNpLzRqMU9OMjRE?=
 =?iso-2022-jp?B?bkc1NjJZdnlZSXMxNWl0dGpGcmRWM01INFpuZGhrcmIvdFl5VFQxZDYz?=
 =?iso-2022-jp?B?Z2gzNVdCbVdnaGJnN3hrR0tqaWFJaTJpTThNRElYV2hnd21JbzZUR1Nn?=
 =?iso-2022-jp?B?blZETjZIZXlwSTJTblgzRng5R0tPZTA2MFF5YXUzVWJtL3RLaHJkTlZo?=
 =?iso-2022-jp?B?SGRYcmk4Yys3OFJwclRaYmFqUkpFSE8xT1hhc2Z2TTJERjB4VndFVWZw?=
 =?iso-2022-jp?B?eDZWY1ZDaW1HS0VJSjRkSTJFTEV0ZVRpZjU1SkVZcTZTWUhXMXFHb1NZ?=
 =?iso-2022-jp?B?NE1OMkt0S2cycDB6V2dtaUIzbFhsTkdycUlZPQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYWPR01MB11063DCBCB8B1B68822A14A84C7D52TYWPR01MB11063jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11063.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47650905-35ce-462d-8fb1-08dd5d8414df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 14:26:42.3280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1aAo4Z44zxXIQrlXb6tVMToOCWtku6tbS1dqhe42DbhaM6kh0jQ3FraaMiLUB3ndemYitGkIl0v0Ae7xB4m7FF9znMOvTqgkqYEXwOAwmfnfh8BHPAHSSq6aVcuw+G9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7083
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Mar 2025 14:27:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18070

--_000_TYWPR01MB11063DCBCB8B1B68822A14A84C7D52TYWPR01MB11063jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

This is regarding the LAVA templates and preparation of LAVA job definition=
s in the gitlab CI.

At the moment, in isar-cip-core repository, the LAVA jobs definitions are g=
etting prepared by using template files.
I understand that this is to avoid code duplication. However the template f=
ile approach doesn=1B$B!G=1B(Bt work well with all the test scenarios.

As part of improve test coverage of swupdate/secure boot[1], we identified =
some test cases and written LAVA job definitions for them.
Each scenario requires different steps/action block or some other changes b=
ased on the test scenario. It will be difficult to handle all these changes=
 using templates approach.

At present, there is a script in isar-cip-core =1B$B!H=1B(Bsubmit_lava.sh=
=1B$B!I=1B(B[2] which modifies few things based on the architecture, distri=
bution(i.e using sed command) even after deriving the job definition from t=
emplates. If we consider to integrate negative test cases of swupdate and s=
ecure boot which makes the submit_lava.sh script more complex and also the =
readability[3].

We may have to add additional test scenarios in future as well so, by consi=
dering all these things I think It would be better to keep the entire job d=
efinitions in the repository instead of deriving it from templates.
Basically we can make use of templates if the changes across multiple jobs =
definitions are less, otherwise we can keep the entire job definitions(comp=
lete .yml) itself in the repository for each case.

What do you think about it?  Please provide your opinion.

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120
[2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scr=
ipts/submit_lava.sh?ref_type=3Dheads
[3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/1e8788d5=
c54ce2eb76048ea2cae11af079a4dbe6

Thanks & Regards
Shivanand K

--_000_TYWPR01MB11063DCBCB8B1B68822A14A84C7D52TYWPR01MB11063jp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-ligatures:none;
	mso-fareast-language:EN-US;}
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
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Chris, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is regarding the LAVA templates and preparation=
 of LAVA job definitions in the gitlab CI.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">At the moment, in isar-cip-core repository, the LAVA=
 jobs definitions are getting prepared by using template files.
<o:p></o:p></p>
<p class=3D"MsoNormal">I understand that this is to avoid code duplication.=
 However the template file approach doesn=1B$B!G=1B(Bt work well with all t=
he test scenarios.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As part of improve test coverage of swupdate/secure =
boot[1], we identified some test cases and written LAVA job definitions for=
 them.<o:p></o:p></p>
<p class=3D"MsoNormal">Each scenario requires different steps/action block =
or some other changes based on the test scenario. It will be difficult to h=
andle all these changes using templates approach.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">At present, there is a script in isar-cip-core =1B$B=
!H=1B(Bsubmit_lava.sh=1B$B!I=1B(B[2] which modifies few things based on the=
 architecture, distribution(i.e using sed command) even after deriving the =
job definition from templates. If we consider to integrate
 negative test cases of swupdate and secure boot which makes the submit_lav=
a.sh script more complex and also the readability[3].
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We may have to add additional test scenarios in futu=
re as well so, by considering all these things I think It would be better t=
o keep the entire job definitions in the repository instead of deriving it =
from templates.
<o:p></o:p></p>
<p class=3D"MsoNormal">Basically we can make use of templates if the change=
s across multiple jobs definitions are less, otherwise we can keep the enti=
re job definitions(complete .yml) itself in the repository for each case.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">What do you think about it? &nbsp;Please provide you=
r opinion. &nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[1] <a href=3D"https://gitlab.com/cip-project/cip-co=
re/isar-cip-core/-/issues/120">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120</a><o:p>=
</o:p></p>
<p class=3D"MsoNormal">[2] <a href=3D"https://gitlab.com/cip-project/cip-co=
re/isar-cip-core/-/blob/master/scripts/submit_lava.sh?ref_type=3Dheads">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scripts=
/submit_lava.sh?ref_type=3Dheads</a><o:p></o:p></p>
<p class=3D"MsoNormal">[3] <a href=3D"https://gitlab.com/cip-project/cip-co=
re/isar-cip-core/-/commit/1e8788d5c54ce2eb76048ea2cae11af079a4dbe6">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/1e8788d5c54c=
e2eb76048ea2cae11af079a4dbe6</a>
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
</div>
</body>
</html>

--_000_TYWPR01MB11063DCBCB8B1B68822A14A84C7D52TYWPR01MB11063jp_--


