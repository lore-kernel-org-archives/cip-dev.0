Return-Path: <SRS0=Pj1V=IQ=lists.cip-project.org=bounce+64572+6291+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E7FC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 07:47:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A040164F18
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 07:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A040164F18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6291+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iqxiYY4521723x3nW3IwI8Ac; Thu, 18 Mar 2021 00:47:44 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.113])
 by mx.groups.io with SMTP id smtpd.web08.5994.1616053662465221804
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Mar 2021 00:47:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6oFgvHYucwBRgn5HF9a2JwA9JJX3ql7ahPVyESnVpXg9ziwqHLp1zETvlpT5bDdinUasonaByyA7BJSOtG7sNfkKhZGo3S3h4Od7jkUJnavPsA4Mjj8WZ8/4pD+dvbTPtJWKe+HPnBddBQqr4DlVglkzln3rNIyvThA5uc47Zkl86PxOhRh+rX9ogvkX1y1ERlXxn7a288UMR3DMEOh4TRy51ocF3ci/CGoSOpmE4FvL5oex3b93i2IEYkiMy6BUJJDo1BXkf1Bp5i2SXAYjojg0prStS92DeOXOqdL81irQm/Rz652ylTcXibRhKOGX8HAj4vGUpGL6sPHKOs66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMlHCv3xnWxqrrOgW0XSWYe0wJYHS+XR300DxXwiV0s=;
 b=ikpJFVgUImED4co/SQs7AlKJakWhbZT8+HkPFKCuOm+zpp/nSoQHq4sOeMin7qDoOJRmcwwGixddIwV5wwXv70skCxYN/YXpqPrMzXpc5nZ9szQ2MUC8VWwJULdp8gl8iH7zl6lJLRvNQ8ox3TmwmdOQg+++sF8L64N+JammTn1c4HAjOcV5+TVfmTGleexYCXS8EkclZJOMRU5wtV+LnPtqOvhrTI2L1AIDcJGLWqGR5eatUKviNxfw5Ac+hcEb9FiLJwJE5h/QkmyVWnSQqVap1Ily0AZvkIEQ8ar33Uf+M/Nv1LLrzVYgrf0gb+KgqN6mXURLiv47eErrNrFsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com (2603:1096:604:84::10)
 by OSAPR01MB4228.jpnprd01.prod.outlook.com (2603:1096:604:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 07:47:38 +0000
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::d89f:2760:aba3:1583]) by OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::d89f:2760:aba3:1583%3]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 07:47:37 +0000
From: "Kento Yoshida" <kento.yoshida.wz@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdcboIL5mO1sCuDBSCKZq7ZbucOPzAAKg42g
Date: Thu, 18 Mar 2021 07:47:37 +0000
Message-ID: 
 <OSYPR01MB5366A7617A5EE65EBD9294EDDF699@OSYPR01MB5366.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972E281920DEC8CA74B9B17A0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY2PR01MB4972E281920DEC8CA74B9B17A0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.50.44.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 456a6ab3-2e22-422a-6ae4-08d8e9e219e6
x-ms-traffictypediagnostic: OSAPR01MB4228:
x-microsoft-antispam-prvs: 
 <OSAPR01MB4228DAB50E734DEAFFC090ACDF699@OSAPR01MB4228.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 i7Bn4SmxmbrKJVthFc8v1BOHmdzkbHgE3m0rRKB7uSV8PFdgH8pj8bK9n60wViLMXdF6u4XA/bobV1NGVYhHh3vUVqDY+ro9Kolwanp1alT6b2SWgtJyFnENE1oA1m1VAbdWvn2ES6NkR3VWbM6+yih9HJUprODjfOe1zWIdbkvlNDuFUb0hq9fL9sd2hLweFwVjAmk+YuOhy0vKEzmYbeu6c4E8nt1ezEU8fC/PH0QTnmGyNQAzg++9Gphv3GOcPy0MAL7x8P0mJHHYVsltApg8CJhb1Un5UHq1z4jInwVFzDWzqf5K71KzyMjJNWZg/8NABW+LRLZEEeGH5qqymA8Z8pUckNjx9ndGyzvZGqgV4uamaNZijVjQa8GjUzZS3bgmkgYqBESjHzb1JLNlqMHyqlbObpUCaGSVSOpUuo81EctUzg/rFzzzG+2p0Q4gHwGzPF8Y0sPJCW3dRubzmvhviZ8R9dgmDq8SwnjGNCKuInS3dtb69Rnk5xJnBjJyUC7PDLZACmeuKQvcm/lndrzadaALD4QVDFmUGxMYNsSKiRmJnLQfv8q8w58k5kIxvCakeznRomz04Pk75ScPRob2ciYJp1sbKdGrrKOiB1ICVBCEslYG1zCM7o0TU3NtFg+Bmt0MYw7Or0bK0/6wZ1xHUuVkEmOI1M29gEQpkfhaPd41PSCaLAWJwEtjGsjR
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?N1J2BcHQ4fvGP07c5lsLoqqobLQrE5bAzU7biFKRqmb8oHnBE3iLru93hSy5?=
 =?us-ascii?Q?OHCEGIKatYxhnNrx/0ftbagxHoYiudebQ6GWSiTb/F/Cq9D9Zh3yymkKZHpm?=
 =?us-ascii?Q?eKCLBhny8PIjmNgqfgUurGH74HcrjUPFLv7h+mSJz27tgaYJAgo8L32cdsTu?=
 =?us-ascii?Q?D2vAk/a54HeUW0jotdlCawVF0j2Lh/5pN9K2WhSstXr59r2wor2mQYdNBINh?=
 =?us-ascii?Q?jjUwXIvmfwRaxPQjzEgi7pBdMG4J+Gqs377l86r+0ZO/wSYm10yTRONWCcZE?=
 =?us-ascii?Q?cXR+ZfF0V0lNRylMAQYZe6LdiaUPyDJkgzHWuVa/zEX9FA8K7cQcBE+NiHtl?=
 =?us-ascii?Q?nVAMS4sjI8pqTBEQDsAfKRfx6ev4XqkH1Bscfq1qQEgLKz8+rNKS/zwpoI3D?=
 =?us-ascii?Q?oC+dDG1y+Jcm4ERlrn75pPvl9RudXnFNpDQNZBZLLK9HDgk1zXbcBstV/JXx?=
 =?us-ascii?Q?4MMUX+AQwfHpg0lGYWq2/zzxhiZ15wuvGeKWv/Cz2qeP8iIK0WHFkjIi8DgE?=
 =?us-ascii?Q?G4zEE/zIXVqoUR4v07IM0QlJBwRILzV87E47maxIDOTFTeFE+n/C7H3WageQ?=
 =?us-ascii?Q?/lmEjW6OeuzBN7dzDFszTpMnwfFWVIBKDaxAaHP3nLIRwyESv4WoyaTBYfeI?=
 =?us-ascii?Q?COTZoktKVXC6PlaFBvHUljppdboU2n2cIRg9cTdY7Sy6zSLkpLWeHZJ7T0P6?=
 =?us-ascii?Q?Sd3P0iabybV1vg/FPK3X1sLol7UG5jif/P5bt8RWtgXB/aD42BTp9epZQq4S?=
 =?us-ascii?Q?spRreLxCzPbGpq3/cfkGQEoq20KuDVr0F+Cn1LBH8y5Kot91aHv79T8uuiFF?=
 =?us-ascii?Q?RV8x+f+5vIfrecNWvwZs7CaU70ekCl9NEwoX2ReqDLo1+3oLZ5SCM/JjoYPq?=
 =?us-ascii?Q?eYyAlWMAo8MToSXoZle5CnhWF+uxWJ3zT+OkrfGNEvI6nyXBwPQznHt5+/SR?=
 =?us-ascii?Q?jU25i6IGvsRzqwmqzKh4HAU5P2HL7BLXlhmTC1TWBbEJtlDAUmFs08jPjqNS?=
 =?us-ascii?Q?X4AGcLdMN2DYHM7C+2qQPc5V2onfGbLmpGd9vt/+C8SH+XqbMRpaXIwH2BVJ?=
 =?us-ascii?Q?Tv6ge5HSLPbbXSCobmvxxUfwyY0x2UdL0vp1Y+TwH+DJqwW4L6YIXT4+LUTT?=
 =?us-ascii?Q?LN5zfYBA8nW8wJyBQF6z3lgPyGi2yQIGyrLOL0ZAWcYAw+J9B6diwLNXCd4f?=
 =?us-ascii?Q?AevTktYfZ6APqd7seaVCz5Th9jtVbnyvDHTnnDcWQXVIwF87mSt3z+3JUPai?=
 =?us-ascii?Q?h2tkH9J8oyl4f9qIQRLKSi+vfGJlgc0Ck2YxKZ2NwWI01YLMWbWG6AQBe/TC?=
 =?us-ascii?Q?4HM=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5366.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456a6ab3-2e22-422a-6ae4-08d8e9e219e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 07:47:37.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBriWstd58ZOCdhNb1GGwF/4XlJwWBBVOqKVJM0UzJVPPaNwXgDWMk8ZUa3KnqZdLnDpOhSp4QDZHEGAJy4YROIQ3j+SocM7mfrPmaUzUlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4228
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 02ry3xqi255hiG5JkHT3vLm4x4520388AA=
Content-Type: multipart/mixed; boundary="CvaDImje7Be8pEwq10Yi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616053664;
 bh=sOFEgpdIQHfPwAdSXKp7UIf/pujKMPjfqUPDtF+UKQ4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=gi+vKznc07PvkXSTJKyqoQaZTre/Xg5Z8IAKi9UALIl/+tMDgwSo4PD4YjuTXfgVrAM
 N34/uIrYn74FswkrE9S/QM8UdmTi0b/r9VVmCw3N4n2wrHKgOcaw14vxSkpIghbeR+G7u
 7kfwqULv6+1QsrkEJK+T1EvkE6OUCwnT7MI=

--CvaDImje7Be8pEwq10Yi
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Kudo-san,

I cannot attend. From SWG, I don't have any update, then please skip the SW=
G part.

Best regards,
Kent

>-----Original Message-----
>From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beh=
alf Of
>masashi.kudo@cybertrust.co.jp via lists.cip-project.org
>Sent: Thursday, March 18, 2021 11:51 AM
>To: cip-dev@lists.cip-project.org
>Subject: [cip-dev] CIP IRC weekly meeting today
>
>Hi all,
>
>Kindly be reminded to attend the weekly meeting through IRC to discuss tec=
hnical
>topics with CIP kernel today.
>
>*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 start=
ing
>from the first week of Apr. according to TSC meeting*
>https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.ti=
mea
>nddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2021%26month%
>3D3%26day%3D18%26hour%3D9%26min%3D0%26sec%3D0%26p1%3D224%26
>p2%3D179%26p3%3D136%26p4%3D37%26p5%3D241%26p6%3D248&amp;dat
>a=3D04%7C01%7Ckento.yoshida.wz%40renesas.com%7C8feaff5f928f495e215908d
>8e9b8ab75%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6375163
>26656218276%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DMVtQ4yd%2F
>KPMEP%2BXP9ontYfH6t7M1VW50jL2%2FND2Cxng%3D&amp;reserved=3D0
>
>USWest	USEast	UK	DE	TW	JP
>02:00	05:00	9:00	10:00	17:00	18:00
>
>Channel:
>* irc:chat.freenode.net:6667/cip
>
>Last meeting minutes:
>https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Firclog=
s.base
>rock.org%2Fmeetings%2Fcip%2F2021%2F03%2Fcip.2021-03-11-09.00.log.html&
>amp;data=3D04%7C01%7Ckento.yoshida.wz%40renesas.com%7C8feaff5f928f495e2
>15908d8e9b8ab75%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6
>37516326656218276%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA
>iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3De3IqI
>DzA9JSf%2BQXMIjX4xGqM5pu3%2Fc2EiSPHIjqmGZw%3D&amp;reserved=3D0
>
>* Action item
>  1. Combine root filesystem with kselftest binary - iwamatsu
>  2. Do some experiment to lower burdens on CI - patersonc
>
>* Kernel maintenance updates
>* Kernel testing
>* CIP Security
>* AOB
>
>The meeting will take 30 min, although it can be extended to an hour if it=
 makes
>sense and those involved in the topics can stay. Otherwise, the topic will=
 be taken
>offline or in the next meeting.
>
>Best regards,
>--
>M. Kudo
>Cybertrust Japan Co., Ltd.

--CvaDImje7Be8pEwq10Yi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6291): https://lists.cip-project.org/g/cip-dev/message=
/6291
Mute This Topic: https://lists.cip-project.org/mt/81421400/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--CvaDImje7Be8pEwq10Yi--
