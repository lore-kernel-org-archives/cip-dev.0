Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED1EC25B74
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 11:40:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.11459.1715859623363603873
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 May 2024 04:40:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 44GBeKFu2163016; Thu, 16 May 2024 20:40:21 +0900
X-Iguazu-Qid: 2yAbrn6vFkDMk3KQ3F
X-Iguazu-QSIG: v=2; s=0; t=1715859620; q=2yAbrn6vFkDMk3KQ3F; m=1GbY7Nt7qiJuuY4Vr24lmTDJabRNrwk4xhlwA1RWl88=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 44GBeJln2352534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 16 May 2024 20:40:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1mxU4o+GLL7H4dGmKrLnXMkHix0Qj6UiHyTmsKUlSPkyf98EczRUmZgMknNjTzmERNE+GiZ0eXo10/iAlza8/kzHwiDNjMwLcACVpbEMXYq/M9s7dPtj6y9/ydrFQOK9akyfY11RXY7WiM2Xh9Ko5XTRUB8KbU/dcaS63AkmkfBK6NxkMqmaPxy5hzZqT1gVSzOi6lSPvDP+BWWa0AEeAmtPD3lpj9+QWezNj95SuPDs17LBgIdeum+6wW/gjsMElQq7C1dRMqOYCL2aOXNn0oodPicSLiArgng7aJWiVrvwE2ew9nUu7G+KSigf7oLeqnyQ5Ri4ooS0QEAEgOsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WXSkiqz2G7uVdQuPcxccjhauQyEJ5HBkot47Y2MWBc=;
 b=RCsJ9r5w/Q4tu15lTy1NKXWUpby6/BRwWK385p/p/aOKpBXTDYkbLHg6iMWiI2FRMg4C/whh2mmqE88er4srXSHGT+scSi1+ifrcjVy/SeGNpDo7EP6+wkGSlR1juaxpGToV9IkjVzWX4hef930T38vMKij5Q4+TtF2BgMQ4HIfOhbCTNnfrTpSFE7K4wlAVhjtHvbaRlLFPGNwvByP9rBvyJpEdRDjarQ0R6DTBqzeBO/05OvenUlLdlwgdTuQZU6fOr264+00prjMxiIwpzJeyl5++TAZ6dQfCYj7oRiRBPoslJKf9FwAdhv2A3vFlf/2uPZOyl/JnwjfyRUBJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: <cip-dev@lists.cip-project.org>
Subject: Preparing test evidences for CIP Core packages for IEC 62443-4-x
 assessment
Thread-Topic: Preparing test evidences for CIP Core packages for IEC 62443-4-x
 assessment
Thread-Index: AdqngyKNF2gl+sOgQmW8Zvoy0bqzgA==
Date: Thu, 16 May 2024 11:40:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669D37EC2865C6595EFD118C4ED2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TY3PR01MB9872:EE_
x-ms-office365-filtering-correlation-id: b1db99ab-8ba9-41f2-4ed1-08dc759cf531
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aWZuR0JBdUxTK0RmT3NEWHl4MTNBQXo0a1VUZ29wYkcwUWxmbnp2aE5X?=
 =?iso-2022-jp?B?eW9VeFJpaTFyNVJ4LzBYZWNjM2g5eE9EL29LZ0JOcjVSalo3Zlh3MGU0?=
 =?iso-2022-jp?B?ckU3Yjd6aEUyMlRKOWp4TTFHUW5MMEljOU5sc2hITERLQTY3cysxc0NR?=
 =?iso-2022-jp?B?cjE4MW8zL0ZRN1RtVjhvMmVaeml2N096djhTMFNjdjNCaEZEeEJoZ0JP?=
 =?iso-2022-jp?B?L2dLZWdFamdhQlN2ZXFVMGVkUlhRNkFMd0YxNzdpVzZLVTgwQU5kQWNO?=
 =?iso-2022-jp?B?VVF0R2ExancwcXFhdDUwYXZPN0x1bTY2V0pDQkJ0SUxCZ1FPdWI1WFdw?=
 =?iso-2022-jp?B?aWJKM0pobGJwVStTRThQOXhGd1RzLzRFY29zelJUelBvVy9OcWJIakxZ?=
 =?iso-2022-jp?B?TlplenFZTDl3cXhWUDlnVWNCcXo2cUNaT3gvRS8ySU52R09qV0diUDM1?=
 =?iso-2022-jp?B?K0F0RHFVKy83MUhsMERuc3N2ZTNCd01ENWgvS0ZzUmM0aVJEeG1vZzRn?=
 =?iso-2022-jp?B?OS9nOFVwb3ZoMk1ZNnpBMXV4NnB5bTBKWXlXcFJPb1RZLzBvOU1lM1da?=
 =?iso-2022-jp?B?WlBxamFGenRINkFDZmJLRXlqRUMvOHRMYk9rcXBYTHRJemI4ZzhmWHRT?=
 =?iso-2022-jp?B?NjNwb0t5ajhGMjBxb3lLK3VEVFVjTUNGSjFmVER4V0tBN0tiSTdpZ21l?=
 =?iso-2022-jp?B?LzQ4dlE5SExQMnVhYXBNcWdkUU5nRzNBQ0NFN29yZUFSZ3Y3ODJ3bG9G?=
 =?iso-2022-jp?B?UEVvRlliTUhEc3RvMFB2ek1QRGQ3UlZENXVUcW9YWlgybjdUSnVqUVVQ?=
 =?iso-2022-jp?B?R3J1WXIxTktPVDZhazh6bmVzZW8zZVpzY050ckpqWk81QkJEalVSRzZE?=
 =?iso-2022-jp?B?bTcxY1FDSzk0MTA0dk8xTU9BMmpIL0E5WFVXNkk2cVpUVVY0N0lDdTE2?=
 =?iso-2022-jp?B?Nitjc3ZpNkI4cDZxOGUyNlptK0laTmJLWVZEUFo5Zytoc2s1c1p5K2cr?=
 =?iso-2022-jp?B?VUNHa0VQbjJJQUlvRHdXdjRySHlyMzF5Z0JrbFIyTlJrSmZHdVJaZTRB?=
 =?iso-2022-jp?B?Y21obUVGOTFFV3Y1cHYxZ3cyWjNYREczK204YW1BMTQ0aTF2cWxENEVz?=
 =?iso-2022-jp?B?YThzU3Z5L2xrOWJvakZ1RkRIbGlSYWdqUzBtekhJWEc2MlVoQVJnWDg4?=
 =?iso-2022-jp?B?a1dJb3AvcTM5LzVKelVHTEh6UUZCQnJWdS9IY3BiZGhpVWxiZlFaRzFr?=
 =?iso-2022-jp?B?OGFXQU1TUDAvUmpFT0NjRVRlNjFHL3VZNVpVdjk4TndOZk5HTDdxSE5h?=
 =?iso-2022-jp?B?aU05QWlXRk5QWXNwTDRCekZnYWw2bmdDZTcwQTNPU1NGTVdUUEkrYlBF?=
 =?iso-2022-jp?B?MEg0VWJIVzYxcXdjMVZLdmNyaWNENnY4dlRXOENZa014VU1CWXdWKzl6?=
 =?iso-2022-jp?B?dzRQeC9uWnE2NHF3U3lVdmRmMUhsK2U4OVRJUmJENG9UbWFRWU1oTmZs?=
 =?iso-2022-jp?B?OEtaYVkzUkJyblpIUk9pMjNoY0t0RmtFMEpHVDUrOURGaDlOWHYxSXNZ?=
 =?iso-2022-jp?B?SGRrZWxtOHBEb1BIL2c2WFVCUk9uM3R1WmRmRnM0NytCSklHQ1M3ditF?=
 =?iso-2022-jp?B?bktibDlEUndiQXJiWTJxYm1iaHE3K0w3Vis0Z2F0ZThXSDBsS2NTRWpW?=
 =?iso-2022-jp?B?WEtnb2lwamFzWktpVEkwdXBzd1kxTVpyZ1dWeTFCeXVmTDFTQTkwZWpY?=
 =?iso-2022-jp?B?SXh0UTV6a0tXK05rcWdlOGRQcUJmdm1kM2lsSXgzWm5lakdNMXpETGtF?=
 =?iso-2022-jp?B?QnZJNzE5SS8wekNGWUdZdUZoV2t0NUpBSFV5VVZxNDdEZVNuK3g5ZVNn?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SnZJNlE0WWZDcWhxc0tJenc0NTVodGpibEZibHMzSXRPZ2Zac09Fd3Zm?=
 =?iso-2022-jp?B?bEwwUDd6Q0FCaFBQbWgxNEFoK1kzblBYSVhNRG1GenNPTXNtQ2hGc2pR?=
 =?iso-2022-jp?B?cXRuQ1hHdXRyNFYyc3VObjgrSENzMUpBem1LNEIxdGw4WXIySlpPaXA3?=
 =?iso-2022-jp?B?cmt2RUVxcmtWQ1BjdzVkUkN0SVp4bHZtcjhxamp4ZVB6TkI5NG9uejZZ?=
 =?iso-2022-jp?B?b3R5L2pzOExRdTV2dG5zNjlFWWNjOCtjTFFTZjBsdlhYclVHaXFQcU02?=
 =?iso-2022-jp?B?TWVkcUtNeTlsRjR1QjZVa1JKUzk3YXhHc29NdCtwUE9mNUU3Rkk3ZVVS?=
 =?iso-2022-jp?B?Y2RiZkd4Q1JuNTJVUHdlM2J3SFZZRmptRTRpK1htV2xDT1hsTlhmS3BO?=
 =?iso-2022-jp?B?OXBNdTR2UGdsaGpmSGZYbTlnSzVIN1ZlbmNiRUlOaC8wV1VZNjdkTkht?=
 =?iso-2022-jp?B?Ny9YZzdFMDJOY2VGSzdUZmREd3NjeG1oeWpVZmpHMTRqUXZrYkdJM3dl?=
 =?iso-2022-jp?B?b0tKL3RhU3lhTmhORGw4cHRlVTVnQWNIQ2hIdzAwRHhxcXd1MSs5WVlt?=
 =?iso-2022-jp?B?MGdFNWpVRG9NdnRUOGNkcTJQT1Q3WGhqT0YvRGMrVDI3TEh2bFM3Y3Rj?=
 =?iso-2022-jp?B?aXlJMUJFNUszL0NNajRwcFhIdjdZMzdRV3dpN3ZOdUszc3dhUlZQMjFK?=
 =?iso-2022-jp?B?cXVUSUxNQ3pGV052bStCc0VybGUvclNOSzkrR0ttNVhzQSsvTStEUnZK?=
 =?iso-2022-jp?B?d3VwUm1venRuYXZSYWFBV1ZIcWRuR0FPdHRvd1M4MzFqQnFvN0dxQ211?=
 =?iso-2022-jp?B?RmhaN1Urb1VJVE1jU2tsU3owUDY1bFc3QWpKRklNWit2TENkeVJYK3Bt?=
 =?iso-2022-jp?B?UHpLY2dqem1aSFVnTW1YRklXNTVXNkx2eG1ITW1SeUJNcVNuVjdSZDJF?=
 =?iso-2022-jp?B?WFA3Y2I0dmx2Q21GNElUd0VZc0N0ZllaYS9qTWwwVjJhOGltL1NLNnBk?=
 =?iso-2022-jp?B?UWg0WjJzdUs0MDAvQmZxZnJ6cXBRaDkrakNzTjdDNlNhTlkxSUlMTXhS?=
 =?iso-2022-jp?B?K08xR2NmYVFqclczdHBtK1hxY2l4eHcrZldEUzFIRkhvQ0FHMVJaZkpP?=
 =?iso-2022-jp?B?aEVWSEFQeGdCeWZML3J5RDJkc2EzNU4wTDNMcU40UVNzZUlKc0RQRDFw?=
 =?iso-2022-jp?B?QWFidVhUQmkzdTRyc3lFWGl5b1pqMUovZmUrQ3hxRkNRMWswaVo2TjFk?=
 =?iso-2022-jp?B?djhlSjgyRElmM0xuUGsrNFNyWUFObHJsOGdQeG1xWHdOazZmMGxZN2hH?=
 =?iso-2022-jp?B?UTd4YmRRbWNXOUlCaXNQNUhHNmMyL2w0TFJ3amo4TEhBcDlKVHorY2Iw?=
 =?iso-2022-jp?B?aFcrRFdIbkdYRDJDWVR3UHErSDVrQ2FUTHhQNEtCc3l5VjhHbmZ6NUw1?=
 =?iso-2022-jp?B?RFNBL0NQYTRRb0IwWktuMXlhTzgvUThMSk9UR2E0VWNHTENaVHoxTkNB?=
 =?iso-2022-jp?B?S0tzdUdTdzRKYWxwUlMzd2FQcU9icDBrem1KSTJBajlxd1pnTzlPQjZH?=
 =?iso-2022-jp?B?b0s1QlNtcDhHS0FyeUU4VkU2aFpKL2Jwc3FoWVB4UnZycnppUk1HYmVo?=
 =?iso-2022-jp?B?Ync0ZEl6Y1p3N0t6TjhsaUt5U2RURDhVekhENFBib1Y5TUJPTG5BSW4w?=
 =?iso-2022-jp?B?em4yOElHckhsb0ZWZEVMSEtMd0xDMUlTSUJOQ2k2M1c4c3hpbXFSR3da?=
 =?iso-2022-jp?B?cmZjUEd3eWU5bjBZWk4vSEFScm1xdm9pUkJjT2tpWHErd09ZL3JMM2VR?=
 =?iso-2022-jp?B?cWFoVUQ2djJrMkhvNWdyd1dwZmRyb3VTVGlVaHJuN0lqYnQ0Z0RMa2h5?=
 =?iso-2022-jp?B?WXdIdG0xa1NrcGZGU0dGTHJ0NGFWQnJEb251OS9HZUdXd1pvc28rUC9U?=
 =?iso-2022-jp?B?bCtOWHp6UlRadm9UUnoyTEprQzNFbUhDSE5YVFYwMExnaGtrL1pqVkZu?=
 =?iso-2022-jp?B?TWRyckdGMUhXTTh1bGNMZWdXdGc0SDh4WHZxRkVBTDhmZmFGL0lOdy8r?=
 =?iso-2022-jp?B?NjBCYVdhTjIxSVhKRW1OUWZ2YUlrUmUzRFBqNERLc0hxeFJGY1hrSmND?=
 =?iso-2022-jp?B?U2NEdnJHaHFwSHdyQnBnQUI5UW04VG1meXlHZEhvUHlVa081TklhUGxX?=
 =?iso-2022-jp?B?NVAveVY3SitpSnZidWk0K21pQVBiQmVTZHl0Q2tqZ29KUzU3UkRwRC8z?=
 =?iso-2022-jp?B?eHB3QmFGUUtUblB2YzM2V2JRYVBUMzF1SStoazgxK0dtRysyL0lTdGRa?=
 =?iso-2022-jp?B?NGpzL1FGdjEvZWxLVjZxVGtVcUFEK3p1RUE3aHB6eG9WQ1V1K3B4TnRE?=
 =?iso-2022-jp?B?UDVocHM9?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669D37EC2865C6595EFD118C4ED2TYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1db99ab-8ba9-41f2-4ed1-08dc759cf531
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 11:40:16.8302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4v91HzheycDkQ+l3X8bJ9EDgbiNv7nBfZUa6upec/zuNywI1QNmFhR1KhNfbq3VHkjvJGfh+mhHNVG880s6ONV9vcSASThtc5BIMQWi5CbFf5Q7IdO/ntUaDwzFnvzU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 May 2024 11:40:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15905

--_000_TYCPR01MB9669D37EC2865C6595EFD118C4ED2TYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Iwamatsu-san,

Hope this message finds you well.

We at the CIP Security Workgroup have been working to collect test evidence=
s for CIP Core packages included in CIP Security image as part of IEC 62443=
-4-x assessment.

To summarize the work done by CIP SWG so far, CIP SWG investigated the numb=
er of packages in CIP Security image and tried to understand the number of =
packages that have test results available in debian and number of packages =
for which we have to run the tests ourselves and provide the results. I am =
including the summary of the packages below:


  *   Total packages in CIP Security image - 242


  *   Custom CIP packages (from isar-cip-core recipes) - 13
     *   These packages are created by recipes in isar-cip-core or isar tha=
t are deployed into image as a .deb file.


  *   Packages with Debian CI autopkgtest - 140
     *   97 packages with functional tests, 41 packages with non-functional=
 tests, 2 packages with no tests running in debian CI


  *   Packages without tests in Debian CI - 89
     *   70 packages have tests available either in debian salsa or upstrea=
m.


  *   Packages without tests in upstream as well - 19

There are a few packages that do not have tests defined in either debian sa=
lsa or upstream. I am listing the packages that do not have tests defined i=
n either debian salsa or upstream below:

Binary Package name
Source package name
Are there Debian CI results ?
Are upstream tests available
Remarks
base-files
base-files
NO
NO

base-passwd
base-passwd
NO
NO

hostname
hostname
NO
NO

libmnl0
libmnl
NO
NO

libnsl2
libnsl
NO
NO

libpam-passwdqc
passwdqc
NO
NO

libpam-pkcs11
pam-pkcs11
NO
NO

libpasswdqc1
passwdqc
NO
NO

libpython3-stdlib
python3-defaults
NO
NO

libreadline8
readline
NO
NO

librtmp1
rtmpdump
NO
NO

linux-base
linux-base
NO
NO

media-types
media-types
NO
NO

net-tools
net-tools
NO
NO
Few functional tests in ubuntu: https://git.launchpad.net/ubuntu/+source/ne=
t-tools/tree/debian/tests
Autopkgtest running in Ubuntu CI https://autopkgtest.ubuntu.com/packages/ne=
t-tools<https://git.launchpad.net/ubuntu/+source/net-tools/tree/debian/test=
s>
python3
python3-defaults
NO
NO

python3-minimal
python3-defaults
NO
NO

readline-common
readline
NO
NO

sysvinit-utils
sysvinit
NO
NO

tpm-udev
tpm-udev
NO
NO


As suggested by you in the previous TSC meeting, we are looking for any tes=
ts available for the above packages in other distributions as well. So far,=
 we have checked ubuntu, where we found a test suite for the net-tools pack=
age. The rest of the packages do not have tests defined in ubuntu as well.

We would like to understand your opinion on the next steps to take or other=
 distributions to target for tests for the above listed packages.

Thanks and Regards,
Adithya Balakumar


--_000_TYCPR01MB9669D37EC2865C6595EFD118C4ED2TYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:215094890;
	mso-list-type:hybrid;
	mso-list-template-ids:633612152 67698689 67698691 67698693 67698689 676986=
91 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Iwamatsu-san,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope this message finds you well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We at the CIP Security Workgroup have been working t=
o collect test evidences for CIP Core packages included in CIP Security ima=
ge as part of IEC 62443-4-x assessment.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">To summarize the work done by CIP SWG so far, CIP SW=
G investigated the number of packages in CIP Security image and tried to un=
derstand the number of packages that have test results available in debian =
and number of packages for which we
 have to run the tests ourselves and provide the results. I am including th=
e summary of the packages below:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Total packages in CIP Security image - 242<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Custom CIP packages (from isar-cip-core recipes) &#8211; 13<o:p></o:p=
></li><ul style=3D"margin-top:0in" type=3D"circle">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level2 =
lfo1">These packages are created by recipes in isar-cip-core or isar that a=
re deployed into image as a .deb file.<o:p></o:p></li></ul>
</ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Packages with Debian CI autopkgtest - 140
<o:p></o:p></li><ul style=3D"margin-top:0in" type=3D"circle">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level2 =
lfo1">97 packages with functional tests, 41 packages with non-functional te=
sts, 2 packages with no tests running in debian CI<o:p></o:p></li></ul>
</ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Packages without tests in Debian CI &#8211; 89<o:p></o:p></li><ul sty=
le=3D"margin-top:0in" type=3D"circle">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level2 =
lfo1">70 packages have tests available either in debian salsa or upstream.<=
o:p></o:p></li></ul>
</ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Packages without tests in upstream as well &#8211; 19<o:p></o:p></li>=
</ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">There are a few packages that do not have tests defi=
ned in either debian salsa or upstream. I am listing the packages that do n=
ot have tests defined in either debian salsa or upstream below:<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"1261" style=3D"width:946.0pt;margin-left:-.15pt;border-coll=
apse:collapse">
<tbody>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid black 1.0pt;border-bottom:none;background:#8EAADB;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Binary Package name<o:p></o:p></sp=
an></b></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Source package name<o:p></o:p></sp=
an></b></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Are there Debian CI results ?<o:p>=
</o:p></span></b></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Are upstream tests available<o:p><=
/o:p></span></b></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Remarks<o:p></o:p></span></b></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;heig=
ht:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-files<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-files<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-passwd<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-passwd<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">hostname<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">hostname<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libmnl0<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libmnl<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libnsl2<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libnsl<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpam-passwdqc<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">passwdqc<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpam-pkcs11<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">pam-pkcs11<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpasswdqc1<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">passwdqc<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpython3-stdlib<o:p></o:p></span></=
p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-defaults<o:p></o:p></span></p=
>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libreadline8<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">readline<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">librtmp1<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">rtmpdump<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">linux-base<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">linux-base<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">media-types<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">media-types<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:45.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">net-tools<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">net-tools<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" valign=3D"bottom" style=3D"width:419.0pt;border-top:none;=
border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wi=
ndowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;height:45.0pt">
<p class=3D"MsoNormal"><u><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none"><a href=3D"https://git.launchpad.n=
et/ubuntu/+source/net-tools/tree/debian/tests"><span style=3D"color:black">=
Few functional tests in ubuntu: https://git.launchpad.net/ubuntu/+source/ne=
t-tools/tree/debian/tests</span><span style=3D"color:black;text-decoration:=
none"><br>
Autopkgtest running in Ubuntu CI </span><span style=3D"color:black">https:/=
/autopkgtest.ubuntu.com/packages/net-tools</span></a><o:p></o:p></span></u>=
</p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-defaults<o:p></o:p></span></p=
>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-minimal<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-defaults<o:p></o:p></span></p=
>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">readline-common<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">readline<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">sysvinit-utils<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">sysvinit<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">tpm-udev<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">tpm-udev<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><br>
As suggested by you in the previous TSC meeting, we are looking for any tes=
ts available for the above packages in other distributions as well. So far,=
 we have checked ubuntu, where we found a test suite for the net-tools pack=
age. The rest of the packages do
 not have tests defined in ubuntu as well.<br>
<br>
We would like to understand your opinion on the next steps to take or other=
 distributions to target for tests for the above listed packages.<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and Regards,<br>
Adithya Balakumar<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_TYCPR01MB9669D37EC2865C6595EFD118C4ED2TYCPR01MB9669jpnp_--


