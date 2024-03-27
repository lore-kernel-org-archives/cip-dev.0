Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F55CC54E67
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 23:31:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.2603.1711582312529613096
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 16:31:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 42RNVndi1950672; Thu, 28 Mar 2024 08:31:50 +0900
X-Iguazu-Qid: 2yAajzvdaf1NxhLmUR
X-Iguazu-QSIG: v=2; s=0; t=1711582308; q=2yAajzvdaf1NxhLmUR; m=KeS42oDs22Ai+M0Oa9spaX4HRJ+MtKU30eaFDwK8JYo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 42RNVmCR1314620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 28 Mar 2024 08:31:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsymku44r7ADbLWakffEpoxwReF1YeIpLd/1pSIJFx9W1pM+P8sqa+nfqqSu2CKKbgmbnZIlrWnAs8WRczf9/MC3mb01DlTsYqM0dA7mIvjmrJaFxFRAUxUQj9t8w3qT8u4s5WUjOxQSbNsqqgQWdeCUoeXZpwLIuMQ/i9eB62glq7HlIa0wpu9NVF+jGT0DBRAp472wiPNdWPOJNljGuWpvowmDaLDlAdXRNl1vpqVIdjOFpytqkhI9Nnn/rK8mQdHbeXVLERhvGL+5Jcjb3j3/2dQ1OLRBeu3u9VMi7+HNDtiZ04WXN23rc5mjWvz3r+PjyJP3g5kPCVDB24iSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeVFwzALsdMV1TQi+RGfkExnpXt5qotCIDB4CGnXhxg=;
 b=IbZT8Vb3YyVGWynrjDt6OLK4AryRML+T3l+UbKtF5EqZhzVvfSRaxLlqOcZEwAQojyXAJ6Z7nTjVpnSHlV6fu2rHA7M6LTgKC48WPilHlhqF+qT74/QGw25HkWRk5vSoc04lfa8/fy/vkvRh+rScglzs2NpjplFMi1PUwPMRLzY3muy6VU4baSa8CMmXxQ7Y6pBO1t1HDP++TK17PMZMxk/ZhN4Lql3JmRu+7/+nhIHA3hJ7slL88hE55VYnvoTzeDADWCRcpgQ/4T6ab+3LFQePFq/GQw6akheZSsdyFokTqJ0E06TK284Tm2Qvjz6jdPlxbFA22+VetEzFDyYQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today (20240328) on libera.chat 
Thread-Topic: CIP IRC weekly meeting today (20240328) on libera.chat 
Thread-Index: AdqAnaAYOxQPKPtLRZCPTxwpVSoQhg==
Date: Wed, 27 Mar 2024 23:31:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388065962011D3080D9384792342@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB8117:EE_
x-ms-office365-filtering-correlation-id: 6fcef7e0-e6ca-476d-5a70-08dc4eb6113e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9DCYwctDajiqCiguxS+Tl9O8x62s1/pk0fxQbg7SK207Sg1RivflPjq+bUjAnw50pfhbf3nz9hsunNkHpEu9J8mN/VZuTAp/sn4Y79+Z9NuPXx+uA24qJj5c2giXUsW96T+9PCYzXV7BOk5muSqTyrQGpdRsrXk7BlAGRcOEIjC8jPsdq4Cn+XR1EvzB8IK8Tbx8FHWdGA0nnA3gqpBcbnbEgg/vViTeR7ZPAbKctIsbZyxkRGFPoZXlENtOQ7WNi7kLIC6UW/ONqHqR6pR2qub4nAFa/CTur/weifmidLyoyU+EJxMzmF8tmrJyfmgUfwuVk/+zxTObYT2/oC8GtOI/923/iKpQcXQkpkfOtD3K9tj1psBrhahetKdXA6dnbPUWjo5Uexcx4yM7JVoTm8hfBOPr2k6b2GDsX6y2ebh0ynOSAqi8OHCzSIuB0tgtl1C75IaTZp2aN20oaHAS0MBnpQKclCNzFM8Chmu9zI6abDm3aY3cRkoGdKktRPn/iSJ6vsQ5IQWLTSEIjTFf9cGlwy43XOesOzJW3xAm3pLTgH9yh0XX1esNuaM1SkoguXDbCKtWCwLSS43QY8w9XyP4qRdR6qZ85oSlIClornXE44MEGUZI47nBAQzPi1sWbLjrTNYqqrBl+MBxOjBNXWM42KTYPhU5pRqJP0Hu3BhGQ4QsFut6w8UAwBReHRrK/tLGyHFwbgH7DeIHfgxvmg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Qk9jUFhCYW1tV0VoUVloSEh5UzAyVU9SQU8vd3FYeDRzUkgxS0NuRmc5?=
 =?iso-2022-jp?B?dFgzOENJUzhiVTBoeFhHczdzMjNLcUFLTkxiM3gvZ3hFT1pWOVFVUDZ3?=
 =?iso-2022-jp?B?ME9LY3V2K0sxVmptalUvYVdvejRmaDc1SlExZ1cySDkwbmxXbkpGUlBJ?=
 =?iso-2022-jp?B?U0FBelI1ajJiSzdpZmcvOGJLNW5XSC9QOVdZUUVRSnFiUGNuM3pQeVZK?=
 =?iso-2022-jp?B?ODBuVDhZNGx3SlROdWd1YzRjTnpyMEVuSllPUkVKakx1M05wbDNtcytO?=
 =?iso-2022-jp?B?aUI1WFFqQ0FsRHpEWXltQkc0cjZ5TzNJdlBtWFI5NXk2RWR5ZzFHTDRV?=
 =?iso-2022-jp?B?bmNQZUxwRzl6ZXdQbWtUOEF4MFV6WngxQWQ0cVM4cXhhYW9RbTJkMDMz?=
 =?iso-2022-jp?B?SDJINzREcnQyTXY3d08xQkhDa3FKdWJHV3o2aTBxaFQ4ZSsxSW5peWtu?=
 =?iso-2022-jp?B?VzJUVDd5ZWZpVjF2QWxlUEtwcVhDUHFreGZERlpwc2FHNlU1UFp3ak5j?=
 =?iso-2022-jp?B?d25LenFUL3lBQVBNVUdMWVlOcGxVZndQWXRJSEVzT2h1MFhoQ2hqS1lH?=
 =?iso-2022-jp?B?M2paWFA4QW9pYm52TjUwWVVHQTZLUEdKSzloSkpzNWt2Mllib2xlK0t0?=
 =?iso-2022-jp?B?MUE3TW5ackYyVjZJOWl0MURxcmtPb20rVWJIa1h2UUpkY1ZSQnozYVpt?=
 =?iso-2022-jp?B?ak5SQndJUk5GL00wdW1DZFArdXhlM1k5OStoaFl2NmhVTVZUKzdRNUtF?=
 =?iso-2022-jp?B?Mi9nZmFmVXVLT2RmN3BKK2VIV3d5VnphL1ovZlpWdHp4VjJxTWR1K0Rv?=
 =?iso-2022-jp?B?SVJSdEhKSjlkNXF1U3I5YlJ6RGtHdHNUV052bWNSVU9GeVNjTTBKSFdz?=
 =?iso-2022-jp?B?L3lxd28yTzNMb2RORHlUZU9xTHBrRS9MZFdQVXR2aUVrUVdkQ0tDNWRZ?=
 =?iso-2022-jp?B?dmFSS3NIQUlyOUZFcDVaSzRwZTZUa2c0V3J3cWl5SHd0d3Y0YVdxSmVX?=
 =?iso-2022-jp?B?cTZtUGRlNk1JWlNMbXorbHBOZTlHMnFaaURMSVpQZU84RTBHTHg1YVVC?=
 =?iso-2022-jp?B?aS9xU2Jtdm5Ea3RIM0RnclRoTzhWUmpGZHhudlRqS29rUmMwRTA0aFNv?=
 =?iso-2022-jp?B?OUJDdmFsV2daVmEzNmdkNW1BYzJ3aHRBRXFwTFhYS2l1bGRuYXVZSWZC?=
 =?iso-2022-jp?B?TDlKbGR6ZGU1bzJsYVB1aUpUS2NPSFkrTERCZUFRc0ZJVHVZMzlzVjVq?=
 =?iso-2022-jp?B?blZIRUIvL3A2dlkzZlJuSlUxdlBwQ2FlWlE4RlMzNytDb1g3T2ExUXVJ?=
 =?iso-2022-jp?B?NGgyOVF6VGdRSW5uSlZCci9iM0JoazE0aWRVYVhDTGs3TWJiRFNrWVIv?=
 =?iso-2022-jp?B?b1cybzJjYzVuWjdjbW8xNFRYYU51d05GUERUTWVDbUpNRHpFd0JjaTg2?=
 =?iso-2022-jp?B?MlkvTGJGWTEwYUhzK0RKekJCWG9jYjhnR21VRG5xN3AzaHdVZGdPNTBL?=
 =?iso-2022-jp?B?eU0yOHZMV0h4ZzRnM1hOWUJsK1dpZy9CdnpxaHdZcVoreDBwcmFsVDY5?=
 =?iso-2022-jp?B?K2I0bTAxT0VhSng4Y1VqSUxMU3U1cUpSVDBQVURQaDJNQmREQW5DYTRy?=
 =?iso-2022-jp?B?Vk9BT0JtK2RTYWE5VUFKVml6NCs0NWVKV3g4Vm9mMlBrbzMvajRydElo?=
 =?iso-2022-jp?B?d3RaY1hxSEYvWkhac0dyNFR4VzNWZkNqLzBZQnVOYzlPdUgzVUJNYmZK?=
 =?iso-2022-jp?B?QTVsYmhGMWk0TTZURFhaSHNreGw2eEVLbThnTWxLdG5rcmZPU0ErSzJE?=
 =?iso-2022-jp?B?UDh2ais0RytybGp2bnJpSzJJRE81eW52Q2lNNUVYUCt2NTRtYlV3b3Jv?=
 =?iso-2022-jp?B?TXR2cHNkYmYvRTBmbWlrWk5WSHlCcXpFdHB0K2pEeFk3a2cvdXZmZDg0?=
 =?iso-2022-jp?B?VmE0ZTV3RktYU1FWRWRuQ1liNzNpSGl4RTlZOWlUMmFKLzErVVBuZENi?=
 =?iso-2022-jp?B?MXFtNjJyTlN2NmFpelJpUkp5Wjh5NGkrUVdxODlYTHE0S0htbEgrMU1I?=
 =?iso-2022-jp?B?c1MxVUx6SWNGVHlCZmU5dGw4WkZoRDVtQVVRRXl2WVNUWVkvV2gzZ1NP?=
 =?iso-2022-jp?B?ZlpiVmNLMTJvM0E5dWxON1MrY0JlTDU0cEJpdUlYZGV5bUpwbmtGblFa?=
 =?iso-2022-jp?B?bHg2dGlOc0twM2VtbzhKM0tOeC9jazU1YTA4cXJWNU5qVEhoMy9sM3Fu?=
 =?iso-2022-jp?B?eHpCdXBzUTlBTUFQZElLSTlKSCttQnhWYkNBSE1vTXluSkM1aUdZZkRz?=
 =?iso-2022-jp?B?Wkt3aTlSTXhvYkcvUkliTXZzdytqcnBjWEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcef7e0-e6ca-476d-5a70-08dc4eb6113e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 23:31:46.0030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QL9iPqP2InlHOo4YbNa9WNLfkzDyCLN74BxHvM/YDy5BJpeqqmd40y2QALtjq/My3gDpVopo5+yHjJDp/V7vvzbkr2uQby5gehfdkM21ZJItJwJKfrsOJhXf/ZZeltD1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8117
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 23:31:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15473

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2024&mont=
h=3D3&day=3D21&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/03/cip.2024-03-21-1=
3.03.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Date the data is created: Wed Mar 27 11:24:12 PM UTC 2024
linux-4.4.y-cip: interval 30 day
  latest version release date: Tue Mar 12 11:03:54 AM UTC 2024
  limit date: Thu Apr 11 11:03:54 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 18 10:21:04 AM UTC 2024
  limit date: Fri May 17 10:21:04 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Fri Mar 22 08:52:01 AM UTC 2024
  limit date: Sun Apr 21 08:52:01 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri Mar  1 08:49:23 PM UTC 2024
  limit date: Tue Apr 30 08:49:23 PM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon Mar 11 06:10:02 AM UTC 2024
  limit date: Wed Apr 10 06:10:02 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Feb  5 05:21:45 PM UTC 2024
  limit date: Fri Apr  5 05:21:45 PM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue Mar 26 05:43:24 AM UTC 2024
  limit date: Wed Apr 10 05:43:24 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun Mar  3 05:34:51 PM UTC 2024
  limit date: Tue Apr  2 05:34:51 PM UTC 2024
  Status: On track

Best regards,
  Nobuhiro


