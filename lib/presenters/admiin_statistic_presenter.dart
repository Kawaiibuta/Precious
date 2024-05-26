import 'package:flutter/material.dart';
import 'package:precious/data_sources/statistic_repository.dart';
import 'package:precious/models/date_statistic/date_statistic.dart';
import 'package:precious/presenters/page_presenter.dart';

abstract class AdminStatisticContract {
  onInitSuccess(List<DateStatistic> value);
  onInitFail();
  onRefreshSuccess(List<DateStatistic> value);
  onRefreshFail();
  onStartAsyncFunction();
  onEndAsyncFunction();
}

class AdminStatisticPresenter implements PagePresenter {
  @override
  List<int> selected = [];

  final AdminStatisticContract _contract;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  AdminStatisticPresenter({required AdminStatisticContract contract})
      : _contract = contract;
  List<DateStatistic> get statisticList =>
      StatisticRepository.list.values.toList();
  Future<void> init() async {
    try {
      _contract.onStartAsyncFunction();
      final response =
          await StatisticRepository.getFromTo(DateTime.now(), DateTime.now());
      _contract.onInitSuccess(response);
    } catch (error) {
      debugPrint(error.toString());
      _contract.onInitFail();
    } finally {
      _contract.onEndAsyncFunction();
    }
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> refresh() async {
    try {
      _contract.onStartAsyncFunction();
      final response = await StatisticRepository.getFromTo(startTime, endTime);
      _contract.onRefreshSuccess(response);
    } catch (error) {
      debugPrint(error.toString());
      _contract.onRefreshFail();
    } finally {
      _contract.onEndAsyncFunction();
    }
  }
}
