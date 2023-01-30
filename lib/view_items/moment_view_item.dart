import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/moment_bloc.dart';
import 'package:wechat_redesign/data/vos/moment_vo.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/fonts.dart';
import 'package:wechat_redesign/utils/extensions.dart';

import '../resources/dimens.dart';

enum ReactionType {
  like,
  heart,
  haha,
}

class PostItemView extends StatefulWidget {
  const PostItemView({
    Key? key,
    this.moment,
    this.uid,
    required this.onTapEdit,
    required this.onTapDelete,
    required this.onTapSaved,
    required this.onTapLiked,
  }) : super(key: key);

  final MomentVO? moment;
  final String? uid;
  final Function onTapEdit;
  final Function onTapDelete;
  final Function(bool) onTapSaved;
  final Function(bool) onTapLiked;

  @override
  State<PostItemView> createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  void onTapLiked() {
    if (widget.moment?.isLike == true) {
      widget.moment?.isLike = false;
      widget.onTapLiked(true);
      widget.moment?.reactions?.remove("${widget.uid}");
      setState(() {});
    } else {
      widget.moment?.isLike = true;
      widget.onTapLiked(false);

      widget.moment?.reactions ??= {};
      widget.moment?.reactions
          ?.addAll({"${widget.uid}": ReactionType.like.name});
      setState(() {});
    }
  }

  void onTapSaved() {
    if (widget.moment?.isBookMarks == true) {
      widget.moment?.isBookMarks = false;
      widget.onTapSaved(false);
      setState(() {});
    } else {
      widget.moment?.isBookMarks = true;
      widget.onTapSaved(true);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: MARGIN_MEDIUM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MARGIN_SMALL,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: '${widget.moment?.profilePicture}',
                        fit: BoxFit.cover,
                        errorWidget: (context, _, __) {
                          return Image.asset('assets/logo.png');
                        },
                      ),
                    ),
                    SizedBox(
                      width: MARGIN_MEDIUM,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.moment?.userName ?? 'User'}",
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontSize: TEXT_REGULAR_2X,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: MARGIN_SMALL,
                        ),
                        Text(
                          "15 min ago",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            fontSize: TEXT_REGULAR,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        widget.onTapEdit();
                      },
                      child: Text("Edit"),
                      value: 'edit',
                    ),
                    PopupMenuItem(
                      onTap: () {
                        widget.onTapDelete();
                      },
                      child: Text("Delete"),
                      value: 'delete',
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2,
            ),
            child: Text(
              '${widget.moment?.description ?? 'descriptions'}',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Visibility(
            visible: widget.moment?.postImages != null &&
                (widget.moment?.postImages?.isNotEmpty ?? false),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.moment?.postImages?.length ?? 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: MARGIN_MEDIUM_2,
                ),
                itemBuilder: (context, index) {
                  var url = widget.moment?.postImages?[index];
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MARGIN_CARD_MEDIUM_2)),
                    child: CachedNetworkImage(
                      imageUrl: url ?? '',
                      fit: BoxFit.cover,
                      errorWidget: (context, _, __) {
                        return Image.asset('assets/logo.png');
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MARGIN_MEDIUM,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM_3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        onTapLiked();
                      },
                      child: Icon(
                          widget.moment?.isLike == true
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          size: 24,
                          color: widget.moment?.isLike == true
                              ? Colors.pink
                              : Theme.of(context).iconTheme.color),
                    ),
                    SizedBox(
                      width: MARGIN_SMALL,
                    ),
                    Text(
                      '${widget.moment?.reactions?.length ?? 0}',
                      style: TextStyle(
                        fontSize: TEXT_REGULAR_2X,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.comment,
                        ),
                        SizedBox(
                          width: MARGIN_SMALL,
                        ),
                        Text(
                          '3',
                          style: TextStyle(
                            fontSize: TEXT_REGULAR_2X,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MARGIN_MEDIUM,
                    ),
                    InkWell(
                      onTap: () {
                        onTapSaved();
                      },
                      child: Icon(
                        widget.moment?.isBookMarks == true
                            ? FontAwesomeIcons.solidBookmark
                            : FontAwesomeIcons.bookmark,
                        color: widget.moment?.isBookMarks == true
                            ? Colors.pink
                            : Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
