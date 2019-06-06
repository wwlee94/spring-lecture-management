package com.lecture.lecturemanagement.calendar;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.util.List;

public interface TimeTableRepository extends JpaRepository<TimeTable,Long> {

//    //table_id로 시간표 하나 찾기
//    @Query("select t from TimeTable t where t.id = :id")
//    TimeTable findAllById(@Param("id") long id);

    @Query("select t from TimeTable t where t.uid=:uid order by t.uid asc")
    List<TimeTable> findAllByUid(@Param("uid") String uid);

    //table_id로 시간표 삭제
    @Transactional
    void deleteTimeTableById(long id);

}
